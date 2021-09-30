Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F40C433EF
	for <linux-s390@archiver.kernel.org>; Thu, 30 Sep 2021 08:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36FBF61880
	for <linux-s390@archiver.kernel.org>; Thu, 30 Sep 2021 08:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349128AbhI3IH1 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 30 Sep 2021 04:07:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6556 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1349047AbhI3IGS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Sep 2021 04:06:18 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18U817oZ013790;
        Thu, 30 Sep 2021 04:04:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=kkPJmvW2xAXV762eAmF0Upv9MHk9Nfc9lsbyksb+m98=;
 b=XoGjjkWjNyd6g3nXdrU3kQU0Kk9mErirbOnCCSf/Ta8yT6ihYQwbQxlNfDQmO9Ixk1+T
 9psKnivPSNT7ZJ+6dGNWLOqVt4F2FriIwMV+buX2kAW1CqRoPhNxgk5pm3RJlnimSZEi
 xJT7cEo52qk1IoRCXnMlRNhXXtbVAzOGjG6p4W7pCjxERwh2Hz7OlZAPbgzug+aoOpl9
 NKfJLCH/CGT5rxyJpt6GQXkPSCTeimC9y5OpXLEWb2kIIaD3rNgT1gwvZCGgS8KYSdNj
 LqChFFVHS0+KkBBfbSJkry8k5z9GiZQXZxEZ6LTGbFgsgMJr5EhdCtb4iRfuOzC+8Zmu rg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bd6phkuxj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Sep 2021 04:04:33 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18U7DGkP024633;
        Thu, 30 Sep 2021 04:04:33 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bd6phkuwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Sep 2021 04:04:32 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18U8268k006351;
        Thu, 30 Sep 2021 08:04:31 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3b9udagswj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Sep 2021 08:04:30 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18U84QaG066106
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Sep 2021 08:04:26 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58A93A404D;
        Thu, 30 Sep 2021 08:04:26 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B797A406D;
        Thu, 30 Sep 2021 08:04:24 +0000 (GMT)
Received: from li-43c5434c-23b8-11b2-a85c-c4958fb47a68.ibm.com (unknown [9.171.49.149])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 30 Sep 2021 08:04:24 +0000 (GMT)
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
To:     Halil Pasic <pasic@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     markver@us.ibm.com, Cornelia Huck <cohuck@redhat.com>,
        linux-s390@vger.kernel.org
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <bd0bc232-8527-a4c7-d9be-3b4541914412@de.ibm.com>
Date:   Thu, 30 Sep 2021 10:04:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210930012049.3780865-1-pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TSWvZ-IXC16uKbmTdBeW7eF2-vSbc9Pd
X-Proofpoint-GUID: 4bTrRFDLcPRUF63OhNJLCQZMPF6C0G-s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-30_02,2021-09-29_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 clxscore=1011
 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109300049
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



Am 30.09.21 um 03:20 schrieb Halil Pasic:
> This patch fixes a regression introduced by commit 82e89ea077b9
> ("virtio-blk: Add validation for block size in config space") and
> enables similar checks in verify() on big endian platforms.
> 
> The problem with checking multi-byte config fields in the verify
> callback, on big endian platforms, and with a possibly transitional
> device is the following. The verify() callback is called between
> config->get_features() and virtio_finalize_features(). That we have a
> device that offered F_VERSION_1 then we have the following options
> either the device is transitional, and then it has to present the legacy
> interface, i.e. a big endian config space until F_VERSION_1 is
> negotiated, or we have a non-transitional device, which makes
> F_VERSION_1 mandatory, and only implements the non-legacy interface and
> thus presents a little endian config space. Because at this point we
> can't know if the device is transitional or non-transitional, we can't
> know do we need to byte swap or not.
> 
> The virtio spec explicitly states that the driver MAY read config
> between reading and writing the features so saying that first accessing
> the config before feature negotiation is done is not an option. The
> specification ain't clear about setting the features multiple times
> before FEATURES_OK, so I guess that should be fine.
> 
> I don't consider this patch super clean, but frankly I don't think we
> have a ton of options. Another option that may or man not be cleaner,
> but is also IMHO much uglier is to figure out whether the device is
> transitional by rejecting _F_VERSION_1, then resetting it and proceeding
> according tho what we have figured out, hoping that the characteristics
> of the device didn't change.
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Fixes: 82e89ea077b9 ("virtio-blk: Add validation for block size in config space")
> Reported-by: markver@us.ibm.com

To make sure that it lands there, meybe add
cc stable 5.14
> ---
>   drivers/virtio/virtio.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 0a5b54034d4b..9dc3cfa17b1c 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -249,6 +249,10 @@ static int virtio_dev_probe(struct device *_d)
>   		if (device_features & (1ULL << i))
>   			__virtio_set_bit(dev, i);
>   
> +	/* Write back features before validate to know endianness */
> +	if (device_features & (1ULL << VIRTIO_F_VERSION_1))
> +		dev->config->finalize_features(dev);
> +
>   	if (drv->validate) {
>   		err = drv->validate(dev);
>   		if (err)
> 
> base-commit: 02d5e016800d082058b3d3b7c3ede136cdc6ddcb
> 
