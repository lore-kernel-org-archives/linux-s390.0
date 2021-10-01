Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D08C433EF
	for <linux-s390@archiver.kernel.org>; Fri,  1 Oct 2021 14:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 123D461247
	for <linux-s390@archiver.kernel.org>; Fri,  1 Oct 2021 14:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354390AbhJAOYX (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 1 Oct 2021 10:24:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35219 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231820AbhJAOYX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 1 Oct 2021 10:24:23 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 191EF3SA012371;
        Fri, 1 Oct 2021 10:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=JbmdkSxaEF4yXZBO0F1n84eojiFyGXJzS9NGEX82Cqo=;
 b=BdsSTlDHU7kxbbIrYpAOzJU/f01z5nl5HKj/7YBBzDuQJlIAi0A6F1BsxA5p7kuw3bdY
 qoNwuAQ/OUrZ9O8ilQNzmlvPggnm8cqOIg4HbaBbn/gmIZM1/4JVmKVi37vHKF4hO7MZ
 uJcfYJnQbT2hMwGZQHlFbyXtKZW2v1SGbmeX+xn555aM+7DAGDSugCyI3kL2BlJEGF5p
 eDOFnWZQICW7YsTpymBsv7P+Y2ZWqhWM90t60O11wvqKIh0eXvJrdqJWEKLCKT5lYHWN
 P080tUvihcAVz/G/buU5e/vjRhPhhfi7Q+7kyPtdR+BMdV6pXpMHqN5LIjL+29RAjtEf EA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3be3x404dm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Oct 2021 10:22:35 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 191EGYDH015445;
        Fri, 1 Oct 2021 10:22:35 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3be3x404d2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Oct 2021 10:22:34 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 191EMQ8Y010036;
        Fri, 1 Oct 2021 14:22:33 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 3b9udabsce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Oct 2021 14:22:32 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 191EMTJC37290458
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Oct 2021 14:22:29 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6FF88A405B;
        Fri,  1 Oct 2021 14:22:29 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92C2FA4060;
        Fri,  1 Oct 2021 14:22:28 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.45.119])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri,  1 Oct 2021 14:22:28 +0000 (GMT)
Date:   Fri, 1 Oct 2021 16:22:13 +0200
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
Message-ID: <20211001162213.18d7375e.pasic@linux.ibm.com>
In-Reply-To: <87ilyi47wn.fsf@redhat.com>
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
        <87r1d64dl4.fsf@redhat.com>
        <20210930130350.0cdc7c65.pasic@linux.ibm.com>
        <87ilyi47wn.fsf@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: exfCrodmIXlVkJkc9hKvfC4BpgA8GqZZ
X-Proofpoint-ORIG-GUID: Vaoyi1vgx55QEMWXOgweG3gTv_zmeocj
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-01_02,2021-10-01_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 spamscore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=999 impostorscore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110010096
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 30 Sep 2021 13:31:04 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Thu, Sep 30 2021, Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > On Thu, 30 Sep 2021 11:28:23 +0200
> > Cornelia Huck <cohuck@redhat.com> wrote:
> >  
> >> On Thu, Sep 30 2021, Halil Pasic <pasic@linux.ibm.com> wrote:
> >>   
> >> > This patch fixes a regression introduced by commit 82e89ea077b9
> >> > ("virtio-blk: Add validation for block size in config space") and
> >> > enables similar checks in verify() on big endian platforms.
> >> >
> >> > The problem with checking multi-byte config fields in the verify
> >> > callback, on big endian platforms, and with a possibly transitional
> >> > device is the following. The verify() callback is called between
> >> > config->get_features() and virtio_finalize_features(). That we have a
> >> > device that offered F_VERSION_1 then we have the following options
> >> > either the device is transitional, and then it has to present the legacy
> >> > interface, i.e. a big endian config space until F_VERSION_1 is
> >> > negotiated, or we have a non-transitional device, which makes
> >> > F_VERSION_1 mandatory, and only implements the non-legacy interface and
> >> > thus presents a little endian config space. Because at this point we
> >> > can't know if the device is transitional or non-transitional, we can't
> >> > know do we need to byte swap or not.
> >> >
> >> > The virtio spec explicitly states that the driver MAY read config
> >> > between reading and writing the features so saying that first accessing
> >> > the config before feature negotiation is done is not an option. The
> >> > specification ain't clear about setting the features multiple times
> >> > before FEATURES_OK, so I guess that should be fine.
> >> >
> >> > I don't consider this patch super clean, but frankly I don't think we
> >> > have a ton of options. Another option that may or man not be cleaner,
> >> > but is also IMHO much uglier is to figure out whether the device is
> >> > transitional by rejecting _F_VERSION_1, then resetting it and proceeding
> >> > according tho what we have figured out, hoping that the characteristics
> >> > of the device didn't change.
> >> >
> >> > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> >> > Fixes: 82e89ea077b9 ("virtio-blk: Add validation for block size in config space")
> >> > Reported-by: markver@us.ibm.com
> >> > ---
> >> >  drivers/virtio/virtio.c | 4 ++++
> >> >  1 file changed, 4 insertions(+)
> >> >
> >> > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> >> > index 0a5b54034d4b..9dc3cfa17b1c 100644
> >> > --- a/drivers/virtio/virtio.c
> >> > +++ b/drivers/virtio/virtio.c
> >> > @@ -249,6 +249,10 @@ static int virtio_dev_probe(struct device *_d)
> >> >  		if (device_features & (1ULL << i))
> >> >  			__virtio_set_bit(dev, i);
> >> >  
> >> > +	/* Write back features before validate to know endianness */
> >> > +	if (device_features & (1ULL << VIRTIO_F_VERSION_1))
> >> > +		dev->config->finalize_features(dev);    
> >> 
> >> This really looks like a mess :(
> >> 
> >> We end up calling ->finalize_features twice: once before ->validate, and
> >> once after, that time with the complete song and dance. The first time,
> >> we operate on one feature set; after validation, we operate on another,
> >> and there might be interdependencies between the two (like a that a bit
> >> is cleared because of another bit, which would not happen if validate
> >> had a chance to clear that bit before).  
> >
> > Basically the second set is a subset of the first set.  
> 
> I don't think that's clear.

Validate can only remove features, or? So I guess after validate
is a subset of before validate.


> 
> >  
> >> 
> >> I'm not sure whether that is even a problem in the spec: while the
> >> driver may read the config before finally accepting features  
> >
> > I'm not sure I'm following you. Let me please qoute the specification:
> > """
> > 4. Read device feature bits, and write the subset of feature bits
> > understood by the OS and driver to the device. During this step the driver MAY read (but MUST NOT write) the device-specific configuration fields to check that it can support the device before accepting it. 
> > 5. Set the FEATURES_OK status bit. The driver MUST NOT accept new feature bits after this step. 
> > """
> > https://docs.oasis-open.org/virtio/virtio/v1.1/cs01/virtio-v1.1-cs01.html#x1-930001  
> 
> Yes, exactly, it MAY read before accepting features. How does the device
> know whether the config space is little-endian or not?
> 

Well that is what we are talking about. One can try to infer things from
the spec. This reset dance I called ugly is probably the cleanest,
because the spec says that re-nego should work.

> >  
> >> , it does
> >> not really make sense to do so before a feature bit as basic as
> >> VERSION_1 which determines the endianness has been negotiated.   
> >
> > Are you suggesting that ->verify() should be after
> > virtio_finalize_features()?  
> 
> No, that would defeat the entire purpose of verify. After
> virtio_finalize_features(), we are done with feature negotiation.
>

Exactly!
 
> > Wouldn't
> > that mean that verify() can't reject feature bits? But that is the whole
> > point of commit 82e89ea077b9 ("virtio-blk: Add validation for block size
> > in config space"). Do you think that the commit in question is
> > conceptually flawed? My understanding of the verify is, that it is supposed
> > to fence features and feature bits we can't support, e.g. because of
> > config space things, but I may be wrong.  
> 
> No, that commit is not really flawed on its own, I think the whole
> procedure may be problematic.
> 

I agree! But that regression really hurts us. Maybe the best band-aid is
to conditional-compile it (not compile the check if s390).

> >
> > The trouble is, feature bits are not negotiated one by one, but basically all
> > at once. I suppose, I did the next best thing to first negotiating
> > VERSION_1.  
> 
> We probably need to special-case VERSION_1 to move at least forward;
> i.e. proceed as if we accepted it when reading the config space.
> 
> The problem is that we do not know what the device assumes when we read
> the config space prior to setting FEATURES_OK. It may assume
> little-endian if it offered VERSION_1, or it may not. The spec does not
> really say what happens before feature negotiation has finished.
> 
No it does not, but I hope, the implementations we care the most about do
little endian if VERSION_1 is set but FEATURES_OK is not yet done. A
transitional device would have to act upon a feature that is set,
because for legacy there is no FEATURES_OK. Where we can run into
trouble is minimum required feature set, e.g. mandatory features.

I will do some testing.

> >
> >  
> >> For
> >> VERSION_1, we can probably go ahead and just assume that we will accept
> >> it if offered, but what about other (future) bits?  
> >
> > I don't quite understand.  
> 
> There might be other bits in the future that change how the config space
> works. We cannot assume that any of those bits will be accepted if
> offered; i.e. we need a special hack for VERSION_1.

I tend to agree. What I didn't consider in this patch is that, setting
bits does not only set bits, but may also change the device in a way,
that clearing the bit would not change it back.

> 
> >
> > Anyway, how do you think we should solve this problem?  
> 
> This is a mess. For starters, we need to think about if we should do
> something in the spec, and if yes, what.. Then, we can probably think
> about how to implement that properly.
>

I agree.

 
> As we have an error right now that is basically a regression, we
> probably need a band-aid to keep going. Not sure if your patch is the
> right approach, maybe we really need to special-case VERSION_1 (the
> "assume we accepted it" hack mentioned above.) This will likely fix the
> reported problem (I assume that is s390x on QEMU); do we know about
> other VMMs? Any other big-endian architectures?

I didn't quite get it. Would this hack take place in QEMU or in the guest
kernel?

> 
> Anyone have any better suggestions?
> 

There is the conditional compile, as an option but I would not say it is
better.

Regards,
Halil
