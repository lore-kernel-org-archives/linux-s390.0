Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35730 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727481AbfLPMSb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 16 Dec 2019 07:18:31 -0500
Subject: Re: [RFC QEMU PATCH] pc-bios/s390-ccw: Add zipl-like "BOOT_IMAGE=x"
 to the kernel parameters
References: <20191216112432.13412-1-thuth@redhat.com>
 <ffea8f68-714b-798e-3563-12f9bf0668fa@de.ibm.com>
 <20191216130920.42711f32.cohuck@redhat.com>
 <aab20f72-6350-b5a7-5bb0-e068b37bd766@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <80cbf5b0-ffbd-688f-8733-58dace78faab@redhat.com>
Date: Mon, 16 Dec 2019 13:18:21 +0100
MIME-Version: 1.0
In-Reply-To: <aab20f72-6350-b5a7-5bb0-e068b37bd766@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Haberland <sth@linux.ibm.com>, qemu-s390x@nongnu.org, psundara@redhat.com, =?UTF-8?Q?Jan_H=c3=b6ppner?= <hoeppner@linux.ibm.com>, linux-s390@vger.kernel.org

On 16/12/2019 13.15, Christian Borntraeger wrote:
[...]
> I just learned from Peter that booting SCSI also has no BOOT_IMAGE (as
> we have no menu). So Thomas, can you find out the use case for the initial
> bug report.  That might give an indication on how to proceed for all cases.

Apparently this parameter is used by Dracut, see:

https://bugzilla.redhat.com/show_bug.cgi?id=1782026#c4

 Thomas
