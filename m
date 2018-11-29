From: "Martin K. Petersen" <martin.petersen@oracle.com>
Date: Thu, 29 Nov 2018 01:40:17 +0000
Subject: Re: [PATCH 01/23] zfcp: make DIX experimental, disabled, and independent of DIF
Message-Id: <yq1mups1x1a.fsf@oracle.com>
In-Reply-To: <1a304f10-3603-882a-207a-7618846af746@linux.ibm.com>
References: <1a304f10-3603-882a-207a-7618846af746@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


Steffen,

As I said, I don't have a problem with having module parameters.

> There's one more important thing that has performance impact: We need to
> pack payload and protection data into the same queue of limited
> length. So for the worst case with DIX, we have to use half the size for
> sg_tablesize to get the other half for sg_prot_tablesize.

Interesting. With the exception of NVMe over PCIe, it's kind of unusual
for modern controllers to have real limits in this area.

> This limits the maximum I/O request size and thus throughput. Using
> read_verify and write_generate does not change the tablesizes, as zfcp
> would still announce support for DIF and DIX. With the new zfcp.dif=1
> and zfcp.dix=0, we can use the full sg_tablesize for payload data and
> sg_prot_tablesize=0. (The DIF "overhead" on the fibre still exists of
> course.)
>
> Are there other ways for accomplishing this which I'm not aware of?

You can set your shost->sg_prot_tablesize. There are pathological corner
cases like dd to the raw block device where you'll suffer if there is
not a 1:1 mapping between data and protection segments. But for regular
I/O where the protection is generated over a whole bio at a time, you
can get away with something smaller.

Anyway. I don't have any problems with you making DIX experimental for
zfcp. Just want to make sure it's done for the right reasons (i.e. not
problems in SCSI or the block layer).

-- 
Martin K. Petersen	Oracle Linux Engineering
