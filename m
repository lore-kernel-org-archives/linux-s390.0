Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31316 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727138AbfLPL3b (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 16 Dec 2019 06:29:31 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBGBIkiv084594
        for <linux-s390@vger.kernel.org>; Mon, 16 Dec 2019 06:29:31 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wwdp0wwd5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 16 Dec 2019 06:29:30 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 16 Dec 2019 11:29:29 -0000
Subject: Re: [RFC QEMU PATCH] pc-bios/s390-ccw: Add zipl-like "BOOT_IMAGE=x"
 to the kernel parameters
References: <20191216112432.13412-1-thuth@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 16 Dec 2019 12:29:24 +0100
MIME-Version: 1.0
In-Reply-To: <20191216112432.13412-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <ffea8f68-714b-798e-3563-12f9bf0668fa@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Stefan Haberland <sth@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, psundara@redhat.com, =?UTF-8?Q?Jan_H=c3=b6ppner?= <hoeppner@linux.ibm.com>, linux-s390@vger.kernel.org



On 16.12.19 12:24, Thomas Huth wrote:
>  Note: I've marked the patch as RFC since I'm not quite sure whether
>  this is really the right way to address this issue: It's unfortunate
>  that we have to mess with different location in ZIPL which might also
>  change again in the future. As suggested by Christian on IRC last week,
>  maybe it would make more sense to change ZIPL to add this parameter
>  already when zipl is installed (i.e. by the Linux userspace "zipl" pro-
>  gram), instead of adding it during boot time? Also, the BOOT_IMAGE para-
>  meter on s390x is quite different from the BOOT_IMAGE paramter that is
>  used on x86 - while s390x only uses one single number here, the x86
>  variant (added by grub2, I guess) uses the boot device + full filename
>  of the kernel on the boot partition. Should we maybe make the s390x
>  variant more conform to x86? If so, I think this really has to be fixed
>  in zipl userspace tool, and not in the s390-ccw bios (and zipl stage3
>  bootloader).

Yes, I actually think we should revisit the whole BOOT_IMAGE scheme on s390.
Maybe we should use the kernel name, or the name of the boot menu entry.
And maybe we should not use 0 (when the default is running) but instead
really use to what 0 points to.
