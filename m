Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A7DC433FE
	for <linux-s390@archiver.kernel.org>; Sun,  3 Oct 2021 05:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFC7861A4F
	for <linux-s390@archiver.kernel.org>; Sun,  3 Oct 2021 05:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbhJCFCm (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 3 Oct 2021 01:02:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9364 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229450AbhJCFCm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 3 Oct 2021 01:02:42 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1934eiEa029361;
        Sun, 3 Oct 2021 01:00:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=9aTRdAry9oa2Td1IOB8PmdFe2TgHdkTyMDM7HsVccss=;
 b=pK7Zn/YGFkmSao2D+JvtM0vGncNFMoTML27y1dDB28L6bqai8iODsCaJgjLQvYECtcDf
 zDAVLVGNEi905b+AO7hRp4gQ6/t0IpAL/mlj91vgsOmndUfgJhfwYc4D6hY41zt42kWO
 bcsnKd8bM6zdyAahdFJg7n55z82o0ZQkqnjX0JE2w6Qzwzj9wwJejD1h9sDtfAL/MrYn
 1fZf+ofCiqD0vaq9VIINYYZI7HCTYuMVY5zpV3IW4D0dQ1ZePU/OWSeLiK17qIoEVhEE
 5xJy1NbVYV2N/MdjBR8j6XRN9Ysa2iWEgbaMgUFue48+xtfIulagi0Jp/DgZqsetmgHM aQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bf5998dy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 03 Oct 2021 01:00:52 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1934v8xV011206;
        Sun, 3 Oct 2021 01:00:52 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bf5998du1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 03 Oct 2021 01:00:52 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1934upE6027032;
        Sun, 3 Oct 2021 05:00:42 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3bef2a54fh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 03 Oct 2021 05:00:42 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19350cLj39256524
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 3 Oct 2021 05:00:38 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F82611C06C;
        Sun,  3 Oct 2021 05:00:38 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E01D11C05C;
        Sun,  3 Oct 2021 05:00:37 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.45.119])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Sun,  3 Oct 2021 05:00:37 +0000 (GMT)
Date:   Sun, 3 Oct 2021 07:00:30 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, markver@us.ibm.com,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
Message-ID: <20211003070030.658fc94e.pasic@linux.ibm.com>
In-Reply-To: <20211002141351-mutt-send-email-mst@kernel.org>
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
        <20210930070444-mutt-send-email-mst@kernel.org>
        <87fstm47no.fsf@redhat.com>
        <20211002141351-mutt-send-email-mst@kernel.org>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zjFRvHS7YL9eje-eFWlRkxwM6doaGMQX
X-Proofpoint-GUID: irBnKU-342cRIG5fuouN_yVNjvz8YDyW
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-02_07,2021-10-01_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 suspectscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110030035
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sat, 2 Oct 2021 14:20:47 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> > >From my perspective the problem is that the version of the device  
> > remains in limbo as long as the features have not yet been finalized,
> > which means that the endianness of the config space remains in limbo as
> > well. Both device and driver might come to different conclusions.  
> 
> Version === legacy versus modern?
> It is true that feature negotiation can not be used by device to decide that
> question simply because it happens too late.
> So let's not use it for that then ;)
> 
> Yes we have VERSION_1 which looks like it should allow this, but
> unfortunately it only helps with that for the driver, not the device.
> 
> In practice legacy versus modern has to be determined by
> transport specific versioning, luckily we have that for all
> specified transports (can't say what happens with rproc).

So if we look at ccw, you say that the revision negotiation already
determines whether VERSION_1 is negotiated or not, and the
feature bit VERSION_1 is superfluous?

That would also imply, that 
1) if revision > 0 was negotiated then the device must offer VERSION_1
2) if revision > 0 was negotiated and the driver cleared VERSION_1
   the device must refuse to operate.
3) if revision > 0 was negotiated then the driver should reject 
   to drive a device if it does not offer VERSION_1
4) if revision > 0 was negotiated the driver must accept VERSION_1
5) if revision > 0 was *not* negotiated then the device should not offer
   VERSION_1 because at this point it is already certain that the device
   can not act in accordance to the virtio 1.0 or higher interface.

Does that sound about right?

IMHO we should also change 
https://docs.oasis-open.org/virtio/virtio/v1.1/cs01/virtio-v1.1-cs01.html#x1-160003
and the definition of VERSION_1 because both sides have to know what is
going on before features are fully negotiated. Or?

Regards,
Halil



