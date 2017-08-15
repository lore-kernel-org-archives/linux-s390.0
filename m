Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 15 Aug 2017 13:30:44 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [RFT 00/13] constify s390 ccw_device_id
References: <1502793344-5368-1-git-send-email-arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1502793344-5368-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-Id: <20170815113044.GC3552@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: schwidefsky@de.ibm.com, sth@linux.vnet.ibm.com, hoeppner@linux.vnet.ibm.com, jwi@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com, maier@linux.vnet.ibm.com, cohuck@redhat.com, pasic@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Aug 15, 2017 at 04:05:31PM +0530, Arvind Yadav wrote:
> ccw_device_id are not supposed to change at runtime. All functions
> working with ccw_device_id provided by <asm/ccwdev.h> work with
> const ccw_device_id. So mark ccw_device_id member of struct ccw driver
> as const. And change all driver relatively.
> 
> Arvind Yadav (13):
>   [RFT 01/13] s390: ccwdev: constify ccw_device_id
>   [RFT 02/13] s390: dasd_eckd: constify ccw_device_id
>   [RFT 03/13] s390: dasd_fba: constify ccw_device_id
>   [RFT 04/13] s390: con3215: constify ccw_device_id
>   [RFT 05/13] s390: raw3270: constify ccw_device_id
>   [RFT 06/13] s390: tape_34xx: constify ccw_device_id
>   [RFT 07/13] s390: tape_3590: constify ccw_device_id
>   [RFT 08/13] s390: vmur: constify ccw_device_id
>   [RFT 09/13] s390: ctcm: constify ccw_device_id
>   [RFT 10/13] s390: lcs: constify ccw_device_id
>   [RFT 11/13] s390: qeth: constify ccw_device_id
>   [RFT 12/13] s390: zfcp: constify ccw_device_id
>   [RFT 13/13] s390: virtio: constify ccw_device_id

Did the constify work reveal a single bug until now? This causes a lot of
code churn, and I'm failing to see an added value here.
In addition this is not worth splitting it into 13(!) patches.
