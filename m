Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56616 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729978AbfJNGS5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 14 Oct 2019 02:18:57 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9E67Q2e131574
        for <linux-s390@vger.kernel.org>; Mon, 14 Oct 2019 02:18:56 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vmk3fgwyg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 14 Oct 2019 02:18:56 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Mon, 14 Oct 2019 07:18:53 +0100
Date: Mon, 14 Oct 2019 08:18:46 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 4/4] s390/zcrypt: fix memleak at release
References: <20191010131333.23635-1-johan@kernel.org>
 <20191010131333.23635-5-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010131333.23635-5-johan@kernel.org>
Message-Id: <20191014061846.GA6834@osiris>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, Fabien Dessenne <fabien.dessenne@st.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Harald Freudenberger <freude@linux.ibm.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, linux-s390@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable <stable@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>

On Thu, Oct 10, 2019 at 03:13:33PM +0200, Johan Hovold wrote:
> If a process is interrupted while accessing the crypto device and the
> global ap_perms_mutex is contented, release() could return early and
> fail to free related resources.
> 
> Fixes: 00fab2350e6b ("s390/zcrypt: multiple zcrypt device nodes support")
> Cc: stable <stable@vger.kernel.org>     # 4.19
> Cc: Harald Freudenberger <freude@linux.ibm.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/s390/crypto/zcrypt_api.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks!
