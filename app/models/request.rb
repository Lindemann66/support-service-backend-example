require "prawn"

class Request < ActiveRecord::Base
  belongs_to :user

  PENDING_STATUS = 1
  FIXED_STATUS = 2
  DENIED_STATUS = 3

  PDF_FILENAME = "report.pdf"

  scope :by_text, -> (text) { where('text like ?', "%#{text}%") }

  def set_status(new_status)
    update_attribute(:status, new_status)
  end

  def as_pdf
    human_status = Settings.request_statuses.to_hash[status.to_s.to_sym]
    Prawn::Document.generate(PDF_FILENAME) do |pdf|
      pdf.text "Report text: #{text} - Report status: #{human_status} - Created by #{user.email} on #{created_at.to_date}"
    end

    File.read(Rails.root.join(PDF_FILENAME))
  end
end
