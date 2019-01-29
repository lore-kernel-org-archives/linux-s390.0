From: "Martin K. Petersen" <martin.petersen@oracle.com>
Date: Tue, 29 Jan 2019 06:15:32 +0000
Subject: Re: [PATCH] zfcp: fix sysfs block queue limit output for max_segment_size
Message-Id: <yq1imy8dm63.fsf@oracle.com>
In-Reply-To: <20190124164034.49749-1-maier@linux.ibm.com>
References: <20190124164034.49749-1-maier@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


Steffen,

> Since v2.6.35 commit 683229845f17 ("[SCSI] zfcp: Report scatter-gather
> limits to SCSI and block layer"), zfcp set dma_parms.max_segment_size ==
> PAGE_SIZE (but without using the setter dma_set_max_seg_size())
> and scsi_host_template.dma_boundary == PAGE_SIZE - 1.

Applied to 5.0/scsi-fixes, thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
