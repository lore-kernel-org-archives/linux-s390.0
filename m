Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F96CC433F5
	for <linux-s390@archiver.kernel.org>; Thu, 30 Sep 2021 11:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74494615E5
	for <linux-s390@archiver.kernel.org>; Thu, 30 Sep 2021 11:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350277AbhI3LFq (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 30 Sep 2021 07:05:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28822 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350208AbhI3LFq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Sep 2021 07:05:46 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18UApclI026909;
        Thu, 30 Sep 2021 07:04:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=zOyS3aCpHcNvgs6h2yG/HaeSlaePlW3ZCZQYIDRaWQQ=;
 b=iNSoFSa3mjC7KyuqvXaudDy9g2lSylHXa/y6GrxgFBag8R71/HCMXS4yMHXaVYNm+RXz
 HwrCQwlTNv1jYfNxGCoB7b26VjI71LMOkgpYLPx5KZ0dVawn3bhKzZANRBivTDVHHOt3
 iGJPj02SgcYUqQmKcnQ+k/rcJfQGPVJHCw9GQBFAc828qtcECJCnE9U2rZNYTCLTaNqZ
 UDd43x39/mwHatQoZQgi8MCERmSlnzV9UEMxaom448ZkbQRWZ9tpsSO83YDB35d7G6e2
 tiNWb0hGsbqrDG7TrIMYCiUAAeRmZwIzf26VhUT8G1eKz23oCYWJhAnOincq+tgD8tVE 1g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bd9gtbpr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Sep 2021 07:04:01 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18UAUEFx005878;
        Thu, 30 Sep 2021 07:04:00 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bd9gtbpqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Sep 2021 07:04:00 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18UB3RZd004686;
        Thu, 30 Sep 2021 11:03:58 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 3bc11f4u8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Sep 2021 11:03:58 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18UB3sGi34210290
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Sep 2021 11:03:54 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E312A4070;
        Thu, 30 Sep 2021 11:03:54 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7DCB2A405F;
        Thu, 30 Sep 2021 11:03:53 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.90.153])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Thu, 30 Sep 2021 11:03:53 +0000 (GMT)
Date:   Thu, 30 Sep 2021 13:03:50 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, markver@us.ibm.com,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
Message-ID: <20210930130350.0cdc7c65.pasic@linux.ibm.com>
In-Reply-To: <87r1d64dl4.fsf@redhat.com>
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
        <87r1d64dl4.fsf@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Q9NbuGk8dVzQQ-mKpFc7e9TzyK3qM7Fw
X-Proofpoint-GUID: TC7kYsbK9cx6S90GIMOAIIgQGIUETl4F
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-30_03,2021-09-30_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1015 adultscore=0 mlxscore=0
 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109300065
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 30 Sep 2021 11:28:23 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Thu, Sep 30 2021, Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > This patch fixes a regression introduced by commit 82e89ea077b9
> > ("virtio-blk: Add validation for block size in config space") and
> > enables similar checks in verify() on big endian platforms.
> >
> > The problem with checking multi-byte config fields in the verify
> > callback, on big endian platforms, and with a possibly transitional
> > device is the following. The verify() callback is called between
> > config->get_features() and virtio_finalize_features(). That we have a
> > device that offered F_VERSION_1 then we have the following options
> > either the device is transitional, and then it has to present the legacy
> > interface, i.e. a big endian config space until F_VERSION_1 is
> > negotiated, or we have a non-transitional device, which makes
> > F_VERSION_1 mandatory, and only implements the non-legacy interface and
> > thus presents a little endian config space. Because at this point we
> > can't know if the device is transitional or non-transitional, we can't
> > know do we need to byte swap or not.
> >
> > The virtio spec explicitly states that the driver MAY read config
> > between reading and writing the features so saying that first accessing
> > the config before feature negotiation is done is not an option. The
> > specification ain't clear about setting the features multiple times
> > before FEATURES_OK, so I guess that should be fine.
> >
> > I don't consider this patch super clean, but frankly I don't think we
> > have a ton of options. Another option that may or man not be cleaner,
> > but is also IMHO much uglier is to figure out whether the device is
> > transitional by rejecting _F_VERSION_1, then resetting it and proceeding
> > according tho what we have figured out, hoping that the characteristics
> > of the device didn't change.
> >
> > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > Fixes: 82e89ea077b9 ("virtio-blk: Add validation for block size in config space")
> > Reported-by: markver@us.ibm.com
> > ---
> >  drivers/virtio/virtio.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > index 0a5b54034d4b..9dc3cfa17b1c 100644
> > --- a/drivers/virtio/virtio.c
> > +++ b/drivers/virtio/virtio.c
> > @@ -249,6 +249,10 @@ static int virtio_dev_probe(struct device *_d)
> >  		if (device_features & (1ULL << i))
> >  			__virtio_set_bit(dev, i);
> >  
> > +	/* Write back features before validate to know endianness */
> > +	if (device_features & (1ULL << VIRTIO_F_VERSION_1))
> > +		dev->config->finalize_features(dev);  
> 
> This really looks like a mess :(
> 
> We end up calling ->finalize_features twice: once before ->validate, and
> once after, that time with the complete song and dance. The first time,
> we operate on one feature set; after validation, we operate on another,
> and there might be interdependencies between the two (like a that a bit
> is cleared because of another bit, which would not happen if validate
> had a chance to clear that bit before).

Basically the second set is a subset of the first set.

> 
> I'm not sure whether that is even a problem in the spec: while the
> driver may read the config before finally accepting features

I'm not sure I'm following you. Let me please qoute the specification:
"""
4. Read device feature bits, and write the subset of feature bits
understood by the OS and driver to the device. During this step the driver MAY read (but MUST NOT write) the device-specific configuration fields to check that it can support the device before accepting it. 
5. Set the FEATURES_OK status bit. The driver MUST NOT accept new feature bits after this step. 
"""
https://docs.oasis-open.org/virtio/virtio/v1.1/cs01/virtio-v1.1-cs01.html#x1-930001

> , it does
> not really make sense to do so before a feature bit as basic as
> VERSION_1 which determines the endianness has been negotiated. 

Are you suggesting that ->verify() should be after
virtio_finalize_features()? Wouldn't
that mean that verify() can't reject feature bits? But that is the whole
point of commit 82e89ea077b9 ("virtio-blk: Add validation for block size
in config space"). Do you think that the commit in question is
conceptually flawed? My understanding of the verify is, that it is supposed
to fence features and feature bits we can't support, e.g. because of
config space things, but I may be wrong.

The trouble is, feature bits are not negotiated one by one, but basically all
at once. I suppose, I did the next best thing to first negotiating VERSION_1.


> For
> VERSION_1, we can probably go ahead and just assume that we will accept
> it if offered, but what about other (future) bits?

I don't quite understand.

Anyway, how do you think we should solve this problem?

Regards,
Halil

> 
> > +
> >  	if (drv->validate) {
> >  		err = drv->validate(dev);
> >  		if (err)  
> 

