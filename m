Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A38C433F5
	for <linux-s390@archiver.kernel.org>; Fri,  1 Oct 2021 07:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BED1E613A0
	for <linux-s390@archiver.kernel.org>; Fri,  1 Oct 2021 07:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbhJAHX3 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 1 Oct 2021 03:23:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47802 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231300AbhJAHX3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 1 Oct 2021 03:23:29 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1917EUqE003866;
        Fri, 1 Oct 2021 03:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=+auYqQBWFVzXygfs16wfY6wyZrHBoiWb8QO4x6kT1oY=;
 b=j087lqmtblQnk5tQT1MFmP7tIemwQxkKeiVpl33+nrfszaW4xbiRCuQhZQgUU9xvgA2o
 Qm3OM9kjzSq3Vwgp8/nuf70yniVYgb3aN3g+jhYoAWtZo+WE0+cTVeokE+68Pkg/V+pj
 Jbg6A0hSw/pAc3veACOaOEV65sLnLZo8Dr76Z6oTAOxLm8175PR354P/g5c1jMFljUpS
 q7M8utJpBbddi/h0glDq36e2sRkn5/4096TdqAfxF+IMbjbIkmIiHrE7f1ZYM3L9AZqP
 KeTqDZguEb6LE/VFtdHYTfsOddwyUWai/5DkUY7FefNW4V6SLT0tTUEPUs0e+ErAHRhq wQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bdws484dd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Oct 2021 03:21:42 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1917I6LN016830;
        Fri, 1 Oct 2021 03:21:42 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bdws484cw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Oct 2021 03:21:42 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1917I5Af027457;
        Fri, 1 Oct 2021 07:21:40 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3b9udaue2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Oct 2021 07:21:40 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1917LaYv43647370
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Oct 2021 07:21:36 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 080AFAE05D;
        Fri,  1 Oct 2021 07:21:36 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 322A8AE056;
        Fri,  1 Oct 2021 07:21:35 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.45.119])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri,  1 Oct 2021 07:21:35 +0000 (GMT)
Date:   Fri, 1 Oct 2021 09:21:25 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, markver@us.ibm.com,
        Cornelia Huck <cohuck@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
Message-ID: <20211001092125.64fef348.pasic@linux.ibm.com>
In-Reply-To: <20210930070444-mutt-send-email-mst@kernel.org>
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
 <20210930070444-mutt-send-email-mst@kernel.org>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lH2xwuMhX2Y3AiUs1ca1bpVL38yP9cmT
X-Proofpoint-GUID: xlT7K0u0aaQPp35iwhVj2WTFIDKe9dpn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-30_07,2021-09-30_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110010047
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 30 Sep 2021 07:12:21 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Sep 30, 2021 at 03:20:49AM +0200, Halil Pasic wrote:
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
> Hmm which transport does this refer to?

It is the same with virtio-ccw and virtio-pci. I see the same problem
with both on s390x. I didn't try with virtio-blk-pci-non-transitional
yet (have to figure out how to do that with libvirt) for pci I used
virtio-blk-pci.

> Distinguishing between legacy and modern drivers is transport
> specific.  PCI presents
> legacy and modern at separate addresses so distinguishing
> between these two should be no trouble.

You mean the device id? Yes that is bolted down in the spec, but
currently we don't exploit that information. Furthermore there
is a fat chance that with QEMU even the allegedly non-transitional
devices only present a little endian config space after VERSION_1
was negotiated. Namely get_config for virtio-blk is implemented in
virtio_blk_update_config() which does virtio_stl_p(vdev,
&blkcfg.blk_size, blk_size) and in there we don't care
about transitional or not:

static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
{
#if defined(LEGACY_VIRTIO_IS_BIENDIAN)
    return virtio_is_big_endian(vdev);
#elif defined(TARGET_WORDS_BIGENDIAN)
    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
        /* Devices conforming to VIRTIO 1.0 or later are always LE. */
        return false;
    }
    return true;
#else
    return false;
#endif
}


> Channel i/o has versioning so same thing?
>

Don't think so. Both a transitional and a non-transitional device
would have to accept revisions higher than 0 if the driver tried to
negotiate those (and we do in our case).
 
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
> 
> I am confused here. So is the problem at the device or at the driver level?

We have a driver regression. Since the 82e89ea077b9 ("virtio-blk: Add
validation for block size in config space") virtio-blk is broken on
s390.

The deeper problem is in the spec. We stated that the driver may read
config space before the feature negotiation is finalized, but we didn't
think enough about what happens when native endiannes is not little
endian in the different cases.

I believe, for non-transitional devices we have a problem in the host as
well (i.e. in QEMU).

> I suspect it's actually the host that has the issue, not
> the guest?

I tend to say we have a problem both in the host and in the guest. I'm
more concerned about the problem in the guest, because that is a really
nasty regression. For the host. I think for legacy we don't have a
problem, because both sides would operate on the assumption no
_F_VERSION_1, IMHO the implementation for the transitional devices is
correct. For non-transitional flavor, it depends on the device. For
example virtio-net and virtio-blk is broken, because we use primitives
like virtio_stl_p() and those don't do the right thing before feature
negotiation is completed. On the other hand virtio-crypto.c as a truly
non-transitional device uses stl_le_p() and IMHO does the right thing.

Thanks for your comments! I hope I managed to answer your questions. I
need some guidance on how do we want to move forward on this.

Regards,
Halil

> 
> 
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
> > +
> >  	if (drv->validate) {
> >  		err = drv->validate(dev);
> >  		if (err)
> > 
> > base-commit: 02d5e016800d082058b3d3b7c3ede136cdc6ddcb
> > -- 
> > 2.25.1  
> 

