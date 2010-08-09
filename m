Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 9 Aug 2010 09:16:25 +0200
From: Christof Schmitt <christof.schmitt@de.ibm.com>
Subject: Re: 2.6.35-git6: s390 build failure (drivers/s390/scsi/zfcp_qdio.c)
Message-ID: <20100809071625.GA3401@schmichrtp.mainz.de.ibm.com>
References: <4C5E9365.5030804@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4C5E9365.5030804@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Sachin Sant <sachinp@in.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, swen@vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Sun, Aug 08, 2010 at 04:52:13PM +0530, Sachin Sant wrote:
> Latest 2.6.35 git - 2.6.35-git6 (cd816a0d8...) fails to build
> on a s390 box with following error :
> 
> drivers/s390/scsi/zfcp_erp.c: In function 'zfcp_erp_thread':
> drivers/s390/scsi/zfcp_erp.c:1337: warning: frame size of 'zfcp_erp_thread' is 280 bytes
> drivers/s390/scsi/zfcp_qdio.c: In function 'zfcp_qdio_siosl':
> drivers/s390/scsi/zfcp_qdio.c:467: error: implicit declaration of function 'ccw_device_siosl'
> make[2]: *** [drivers/s390/scsi/zfcp_qdio.o] Error 1
> 
> This problem seem to have been introduced with git2 (3cfc2c42c1c...) via
> commit 339f4f4eab80caa6cf0d39fb057ad6ddb84ba91e
> 
> [SCSI] zfcp: Trigger logging in the FCP channel on qdio error conditions

The zfcp commit calls a function that is introduced with
"[S390] cio: CHSC SIOSL Support"
http://148.100.100.18/cgi-bin/gitweb.cgi?p=linux-2.6.git;a=commit;h=c40306ed03b25a71e8a6cb7162e970d9a29c4242

This patch should be part of the s390 patches for the 2.6.36 merge
window. To build the kernel now, either remove the zfcp patch or apply
the cio patch.

Christof
