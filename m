Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDE5C4332F
	for <linux-s390@archiver.kernel.org>; Tue,  5 Oct 2021 10:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54E7761507
	for <linux-s390@archiver.kernel.org>; Tue,  5 Oct 2021 10:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbhJEKpK (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 5 Oct 2021 06:45:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51094 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233490AbhJEKpK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Oct 2021 06:45:10 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 195Ag5nD022127;
        Tue, 5 Oct 2021 06:43:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=O0ETquogX/CbUx5MWtJl1c2RG0MtCIXZz4D3LkK0Iig=;
 b=o8MZiF6BI2ADgZUUubwkKG07SVflEpHkKQfZrUdyDiZQL2tZ9v6KUE6eifBUctWl8baq
 tExFuLp4Jc7dDnDFPj0Q9eO7lv6J+UEnIUI8zBDpJAdRq9l4jceQJB2MIXZL9OM0Hh40
 BL2q5N/hv2h9m3+4JOXGVoS1ZfPec6bKNyHAu7qq5JvO39OMInhG7cLZ8IoVTVEBa0jj
 xFWUotfggqj/eLTQuZ5TRcXBSXIDPT3h7VXJYuUb6/3WCFm8bHy5J9fowYbpUdFjov+E
 F1CQjA6dYC20EKvCxAPZimg0i5u+CzEQsLuATrJHu3H9QCHkZbWgses//fnO7NSLmi2k vw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bgn6580kb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Oct 2021 06:43:12 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 195AgJUI022768;
        Tue, 5 Oct 2021 06:43:12 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bgn6580jk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Oct 2021 06:43:12 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 195AbB74000895;
        Tue, 5 Oct 2021 10:43:10 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3bef2a16g9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Oct 2021 10:43:10 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 195AboLd57409834
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Oct 2021 10:37:50 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0F9B11C09D;
        Tue,  5 Oct 2021 10:43:06 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D02CE11C0A5;
        Tue,  5 Oct 2021 10:43:05 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.45.119])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue,  5 Oct 2021 10:43:05 +0000 (GMT)
Date:   Tue, 5 Oct 2021 12:43:03 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-s390@vger.kernel.org, markver@us.ibm.com,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Xie Yongji <xieyongji@bytedance.com>, stefanha@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
Message-ID: <20211005124303.3abf848b.pasic@linux.ibm.com>
In-Reply-To: <20211004040937-mutt-send-email-mst@kernel.org>
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
        <87r1d64dl4.fsf@redhat.com>
        <20210930130350.0cdc7c65.pasic@linux.ibm.com>
        <87ilyi47wn.fsf@redhat.com>
        <20211001162213.18d7375e.pasic@linux.ibm.com>
        <87v92g3h9l.fsf@redhat.com>
        <20211002082128-mutt-send-email-mst@kernel.org>
        <20211004042323.730c6a5e.pasic@linux.ibm.com>
        <20211004040937-mutt-send-email-mst@kernel.org>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MjXJXIyQ_EBeczd8gnT2-u7kL5Bwnu8J
X-Proofpoint-GUID: HGrQ7TrKG7fwZWRxJMzNzAYS_onEXAHR
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-04_05,2021-10-04_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 phishscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110050061
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 4 Oct 2021 05:07:13 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Oct 04, 2021 at 04:23:23AM +0200, Halil Pasic wrote:
> > On Sat, 2 Oct 2021 14:13:37 -0400
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >   
> > > > Anyone else have an idea? This is a nasty regression; we could revert the
> > > > patch, which would remove the symptoms and give us some time, but that
> > > > doesn't really feel right, I'd do that only as a last resort.    
> > > 
> > > Well we have Halil's hack (except I would limit it
> > > to only apply to BE, only do devices with validate,
> > > and only in modern mode), and we will fix QEMU to be spec compliant.
> > > Between these why do we need any conditional compiles?  
> > 
> > We don't. As I stated before, this hack is flawed because it
> > effectively breaks fencing features by the driver with QEMU. Some
> > features can not be unset after once set, because we tend to try to
> > enable the corresponding functionality whenever we see a write
> > features operation with the feature bit set, and we don't disable, if a
> > subsequent features write operation stores the feature bit as not set.  
> 
> Something to fix in QEMU too, I think.

Possibly. But it is the same situation: it probably has a long
history. And it may even make some sense. The obvious trigger for
doing the conditional initialization for modern is the setting of
FEATURES_OK. The problem is, legacy doesn't do FEATURES_OK. So we would
need a different trigger.

> 
> > But it looks like VIRTIO_1 is fine to get cleared afterwards.  
> 
> We'd never clear it though - why would we?
> 

Right.

> > So my hack
> > should actually look like posted below, modulo conditions.  
> 
> 
> Looking at it some more, I see that vhost-user actually
> does not send features to the backend until FEATURES_OK.

I.e. the hack does not work for transitional vhost-user devices,
but it doesn't break them either.

Furthermore, I believe there is not much we can do to support
transitional devices with vhost-user and similar, without extending
the protocol. The transport specific detection idea would need a new
vhost-user thingy to tell the device what has been figured
out, right?

In theory modern only could work, if the backends were paying extra
attention to endianness, instead of just assuming that the code is
running little-endian.

> However, the code in contrib for vhost-user-blk at least seems
> broken wrt endian-ness ATM.

Agree. For example config is native endian ATM AFAICT. 

> What about other backends though?

I think whenever the config is owned and managed by the vhost-backend
we have a problem with transitional. And we don't have everything in
the protocol to deal with this problem.

I didn't check modern for the different vhost-user backends. I don't
think we recommend our users on s390 to use those. My understanding
of the use-cases is far form complete.

> Hard to be sure right?

I agree.

> Cc Raphael and Stefan so they can take a look.
> And I guess it's time we CC'd qemu-devel too.
> 
> For now I am beginning to think we should either revert or just limit
> validation to LE and think about all this some more. And I am inclining
> to do a revert.

I'm fine with either of these as a quick fix, but we will eventually have
to find a solution. AFAICT this solution works for the s390 setups we
care about the most, but so would a revert.



> These are all hypervisors that shipped for a long time.
> Do we need a flag for early config space access then?

You mean a feature bit? I think it is a good idea even if
it weren't strictly necessary. We will have a behavior change
for some devices, and I think the ability to detect those
is valuable.

Your spec change proposal, makes it IMHO pretty clear, that
we are changing our understanding of how transitional should work.
Strictly, transitional is not a normative part of the spec AFAIU,
but still...


> 
> 
> 
> > 
> > Regarding the conditions I guess checking that driver_features has
> > F_VERSION_1 already satisfies "only modern mode", or?  
> 
> Right.
> 
> > For now
> > I've deliberately omitted the has verify and the is big endian
> > conditions so we have a better chance to see if something breaks
> > (i.e. the approach does not work). I can add in those extra conditions
> > later.  
> 
> Or maybe if we will go down that road just the verify check (for
> performance). I'm a bit unhappy we have the extra exit but consistency
> seems more important.
> 

I'm fine either way. The extra exit is only for the initialization and
one per 1 device, I have no feeling if this has a measurable performance
impact.


> > 
> > --------------------------8<---------------------
> > 
> > From: Halil Pasic <pasic@linux.ibm.com>
> > Date: Thu, 30 Sep 2021 02:38:47 +0200
> > Subject: [PATCH] virtio: write back feature VERSION_1 before verify
> > 
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
> 
> Well we established that we can know. Here's an alternative explanation:


I thin we established how this should be in the future, where a transport
specific mechanism is used to decide are we operating in legacy mode or
in modern mode. But with the current QEMU reality, I don't think so.
Namely currently the switch native-endian config -> little endian config
happens when the VERSION_1 is negotiated, which may happen whenever
the VERSION_1 bit is changed, or only when FEATURES_OK is set
(vhost-user).

This is consistent with device should detect a legacy driver by checking
for VERSION_1, which is what the spec currently says.

So for transitional we start out with native-endian config. For modern
only the config is always LE.

The guest can distinguish between a legacy only device and a modern
capable device after the revision negotiation. A legacy device would
reject the CCW.

But both a transitional device and a modern only device would accept
a revision > 0. So the guest does not know for ccw.



> 
> 	The virtio specification virtio-v1.1-cs01 states:
> 
> 	Transitional devices MUST detect Legacy drivers by detecting that
> 	VIRTIO_F_VERSION_1 has not been acknowledged by the driver.
> 	This is exactly what QEMU as of 6.1 has done relying solely
> 	on VIRTIO_F_VERSION_1 for detecting that.
> 
> 	However, the specification also says:
> 	driver MAY read (but MUST NOT write) the device-specific
> 	configuration fields to check that it can support the device before
> 	accepting it.

s/ accepting it/setting FEATURES_OK
> 
> 	In that case, any device relying solely on VIRTIO_F_VERSION_1

s/any device/any transitional device/

> 	for detecting legacy drivers will return data in legacy format.

E.g. virtio-crypto does not support legacy, and thus it is always
providing an LE config space.

> 	In particular, this implies that it is in big endian format
> 	for big endian guests. This naturally confuses the driver
> 	which expects little endian in the modern mode.
> 
> 	It is probably a good idea to amend the spec to clarify that
> 	VIRTIO_F_VERSION_1 can only be relied on after the feature negotiation
> 	is complete. However, we already have regression so let's
> 	try to address it.
> 
> 

I can take the new description without any changes if you like. I care
more about getting a decent fix, than a perfect patch description. Should
I send out a non-RFC with that implements the proposed changes?

> > 
> > The virtio spec explicitly states that the driver MAY read config
> > between reading and writing the features so saying that first accessing
> > the config before feature negotiation is done is not an option. The
> > specification ain't clear about setting the features multiple times
> > before FEATURES_OK, so I guess that should be fine to set F_VERSION_1
> > since at this point we already know that we are about to negotiate
> > F_VERSION_1.
> > 
> > I don't consider this patch super clean, but frankly I don't think we
> > have a ton of options. Another option that may or man not be cleaner,
> > but is also IMHO much uglier is to figure out whether the device is
> > transitional by rejecting _F_VERSION_1, then resetting it and proceeding
> > according tho what we have figured out, hoping that the characteristics
> > of the device didn't change.  
> 
> An empty line before tags.
>

Sure!
 
> > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > Fixes: 82e89ea077b9 ("virtio-blk: Add validation for block size in config space")
> > Reported-by: markver@us.ibm.com  
> 
> Let's add more commits that are affected. E.g. virtio-net with MTU
> feature bit set is affected too.
> 
> So let's add Fixes tag for:
> commit 14de9d114a82a564b94388c95af79a701dc93134
> Author: Aaron Conole <aconole@redhat.com>
> Date:   Fri Jun 3 16:57:12 2016 -0400
> 
>     virtio-net: Add initial MTU advice feature
>     

I believe  drv->probe(dev) is called after the real finalize, so
that access should be fine or?

Don't we just have to look out for verify?

Isn't the problematic commit fe36cbe0671e ("virtio_net: clear MTU when
out of range")?

The problem with commit 14de9d114a82a is that the device won't know,
the driver didn't take the advice (for the MTU because it deemed its
value invalid). But that doesn't really hurt us.

On the other hand with fe36cbe0671e we may deem a valid MTU in the
config space invalid because of the endiannes mess-up. I that case
we would discard a perfectly good MTU advice.

> I think that's all, but pls double check me.


Looks good!
$ git grep -e '\.validate' -- '*virtio*'
drivers/block/virtio_blk.c:     .validate                       = virtblk_validate,
drivers/firmware/arm_scmi/virtio.c:     .validate = scmi_vio_validate,
drivers/net/virtio_net.c:       .validate =     virtnet_validate,
drivers/virtio/virtio_balloon.c:        .validate =     virtballoon_validate,
sound/virtio/virtio_card.c:     .validate = virtsnd_validate,

But only blk and net access config space from validate.

> 
> 
> > ---
> >  drivers/virtio/virtio.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > index 0a5b54034d4b..2b9358f2e22a 100644
> > --- a/drivers/virtio/virtio.c
> > +++ b/drivers/virtio/virtio.c
> > @@ -239,6 +239,12 @@ static int virtio_dev_probe(struct device *_d)
> >  		driver_features_legacy = driver_features;
> >  	}
> >  
> > +	/* Write F_VERSION_1 feature to pin down endianness */
> > +	if (device_features & (1ULL << VIRTIO_F_VERSION_1) & driver_features) {
> > +		dev->features = (1ULL << VIRTIO_F_VERSION_1);
> > +		dev->config->finalize_features(dev);
> > +	}
> > +
> >  	if (device_features & (1ULL << VIRTIO_F_VERSION_1))
> >  		dev->features = driver_features & device_features;
> >  	else
> > -- 
> > 2.31.1
> > 
> > 
> > 
> > 
> > 
> >    
> 
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization

