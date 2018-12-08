From: "Martin K. Petersen" <martin.petersen@oracle.com>
Date: Sat, 08 Dec 2018 02:38:03 +0000
Subject: Re: [PATCH v2 01/23] zfcp: make DIX experimental, disabled, and independent of DIF
Message-Id: <yq1tvjon3p0.fsf@oracle.com>
In-Reply-To: <1543493396-1348-1-git-send-email-maier@linux.ibm.com>
References: <1543493396-1348-1-git-send-email-maier@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


Steffen,

> Introduce separate zfcp module parameters to individually select
> support for: DIF which should work (zfcp.dif, which used to be
> DIF+DIX, disabled) or DIX+DIF which can cause trouble (zfcp.dix, new,
> disabled).

Applied to 4.21/scsi-queue.

-- 
Martin K. Petersen	Oracle Linux Engineering
