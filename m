Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA13BC433F5
	for <linux-s390@archiver.kernel.org>; Mon,  4 Oct 2021 02:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 792E261351
	for <linux-s390@archiver.kernel.org>; Mon,  4 Oct 2021 02:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhJDCZj (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 3 Oct 2021 22:25:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39926 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229550AbhJDCZj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 3 Oct 2021 22:25:39 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1942HAJn013952;
        Sun, 3 Oct 2021 22:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=BtW7404GpwTKkqUTjmtVhCQlU8hAD4j8yFpxhidkv9E=;
 b=Scl5gXNsWoxA+9pclCDWadANOxwMTegy+ilhXb141GCCW0y6vT8DgNC0IqTJ53husE6x
 n5x6mqzCdiofe92xGUQlCSrxBY6S+SP/RS8gWlu56xWfUczEJ4WfAujSY7Q6vKpwXeBm
 hLHrOwIhwcseEa5XJkCSVE3v2eQQjd16T2wCIRdyr8pyHFSFI1kJ0bWRfV1NeoBqoHhQ
 NWPX7DNBFVmQvBiUSijIxJB+JmS7IZZLqxsz/RdUU+fE1+y+wDuwT6aG7OpRC3HpZyYH
 glgS+9eYP6yZrc3f9oYVqReHiz5p3OvMrFoWeYK+huDQ2zCAcjocz6VNXEy9E2N436k6 Rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bfrprr2et-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 03 Oct 2021 22:23:48 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1942NmPB004228;
        Sun, 3 Oct 2021 22:23:48 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bfrprr2eb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 03 Oct 2021 22:23:48 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1942MT84009622;
        Mon, 4 Oct 2021 02:23:46 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 3bef290aje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Oct 2021 02:23:45 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1942IQpa56492426
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Oct 2021 02:18:26 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5760A42045;
        Mon,  4 Oct 2021 02:23:42 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE12342041;
        Mon,  4 Oct 2021 02:23:41 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.45.119])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon,  4 Oct 2021 02:23:41 +0000 (GMT)
Date:   Mon, 4 Oct 2021 04:23:23 +0200
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
Message-ID: <20211004042323.730c6a5e.pasic@linux.ibm.com>
In-Reply-To: <20211002082128-mutt-send-email-mst@kernel.org>
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
        <87r1d64dl4.fsf@redhat.com>
        <20210930130350.0cdc7c65.pasic@linux.ibm.com>
        <87ilyi47wn.fsf@redhat.com>
        <20211001162213.18d7375e.pasic@linux.ibm.com>
        <87v92g3h9l.fsf@redhat.com>
        <20211002082128-mutt-send-email-mst@kernel.org>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Y7yW0o3qPlgrIsoRY6SAyO-846f8MTod
X-Proofpoint-GUID: x2D0ejPsNex5tElS_xlaqVr8c-MW3FnQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-03_11,2021-10-01_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110040013
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sat, 2 Oct 2021 14:13:37 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> > Anyone else have an idea? This is a nasty regression; we could revert the
> > patch, which would remove the symptoms and give us some time, but that
> > doesn't really feel right, I'd do that only as a last resort.  
> 
> Well we have Halil's hack (except I would limit it
> to only apply to BE, only do devices with validate,
> and only in modern mode), and we will fix QEMU to be spec compliant.
> Between these why do we need any conditional compiles?

We don't. As I stated before, this hack is flawed because it
effectively breaks fencing features by the driver with QEMU. Some
features can not be unset after once set, because we tend to try to
enable the corresponding functionality whenever we see a write
features operation with the feature bit set, and we don't disable, if a
subsequent features write operation stores the feature bit as not set.
But it looks like VIRTIO_1 is fine to get cleared afterwards. So my hack
should actually look like posted below, modulo conditions.

Regarding the conditions I guess checking that driver_features has
F_VERSION_1 already satisfies "only modern mode", or? For now
I've deliberately omitted the has verify and the is big endian
conditions so we have a better chance to see if something breaks
(i.e. the approach does not work). I can add in those extra conditions
later.

--------------------------8<---------------------

From: Halil Pasic <pasic@linux.ibm.com>
Date: Thu, 30 Sep 2021 02:38:47 +0200
Subject: [PATCH] virtio: write back feature VERSION_1 before verify

This patch fixes a regression introduced by commit 82e89ea077b9
("virtio-blk: Add validation for block size in config space") and
enables similar checks in verify() on big endian platforms.

The problem with checking multi-byte config fields in the verify
callback, on big endian platforms, and with a possibly transitional
device is the following. The verify() callback is called between
config->get_features() and virtio_finalize_features(). That we have a
device that offered F_VERSION_1 then we have the following options
either the device is transitional, and then it has to present the legacy
interface, i.e. a big endian config space until F_VERSION_1 is
negotiated, or we have a non-transitional device, which makes
F_VERSION_1 mandatory, and only implements the non-legacy interface and
thus presents a little endian config space. Because at this point we
can't know if the device is transitional or non-transitional, we can't
know do we need to byte swap or not.

The virtio spec explicitly states that the driver MAY read config
between reading and writing the features so saying that first accessing
the config before feature negotiation is done is not an option. The
specification ain't clear about setting the features multiple times
before FEATURES_OK, so I guess that should be fine to set F_VERSION_1
since at this point we already know that we are about to negotiate
F_VERSION_1.

I don't consider this patch super clean, but frankly I don't think we
have a ton of options. Another option that may or man not be cleaner,
but is also IMHO much uglier is to figure out whether the device is
transitional by rejecting _F_VERSION_1, then resetting it and proceeding
according tho what we have figured out, hoping that the characteristics
of the device didn't change.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Fixes: 82e89ea077b9 ("virtio-blk: Add validation for block size in config space")
Reported-by: markver@us.ibm.com
---
 drivers/virtio/virtio.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 0a5b54034d4b..2b9358f2e22a 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -239,6 +239,12 @@ static int virtio_dev_probe(struct device *_d)
 		driver_features_legacy = driver_features;
 	}
 
+	/* Write F_VERSION_1 feature to pin down endianness */
+	if (device_features & (1ULL << VIRTIO_F_VERSION_1) & driver_features) {
+		dev->features = (1ULL << VIRTIO_F_VERSION_1);
+		dev->config->finalize_features(dev);
+	}
+
 	if (device_features & (1ULL << VIRTIO_F_VERSION_1))
 		dev->features = driver_features & device_features;
 	else
-- 
2.31.1





 
