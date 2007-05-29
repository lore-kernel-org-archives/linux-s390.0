From: James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: [PATCH 1/3] zfcp: IO stall after path checker changes
Date: Tue, 29 May 2007 10:51:55 -0500
Message-ID: <1180453916.3700.29.camel@mulgrave.il.steeleye.com>
References: <200705291529.39677.swen.schillig@freenet.de>
	 <200705291555.27555.swen@vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <200705291555.27555.swen@vnet.ibm.com>
Sender: linux-scsi-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-scsi/>
List-Post: <mailto:linux-scsi@vger.kernel.org>
To: Swen Schillig <swen@vnet.ibm.com>
Cc: linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, mloehr2@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Tue, 2007-05-29 at 15:55 +0200, Swen Schillig wrote:
> I just saw that I posted this patch on 9th already, 
> but todays git pull from your tree didn't show the inclusion of this one (and another patch posted the same day).
> Event though it's reported in your summary from the 26 !
> If I'm to quick then I'm sorry for sending it twice, if there's any other
> reason for this patch to not be included please let me know.

Sorry ... must have missed it.  I'll add it to rc-fixes (unfortunately I
need linus to pull before I can push into this tree, so there'll be a
slight delay).

James
