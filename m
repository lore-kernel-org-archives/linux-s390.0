Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BF11B87DA;
	Mon, 20 Jan 2025 10:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737369279; cv=none; b=jmpu/xef7vA/GMwkBxA6VM8AZr38SowWxR8gqXKKxfxbHyQ/SworQFJ/tSjMnDW2Rs9Fu4pf8IRpP+Wq45ypfbJdLEcexktlBRSqMIdwIh/mEgGlcXTejL1FAfUXYODfJk0DZb81gQoK1RLYugANd5ZhisblVaUa8M73UOEUgsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737369279; c=relaxed/simple;
	bh=v6ddbxKgTtt6BmeDcmWr96r7n4kvLLAYtXn2zQv3c8A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kbk0L+mchLw1AfZIX/Rx8zSlEygWsA5ih0+hGVM3fR5oGrZ26rlwsXF+AEZgtCptWROCOMWkJhPi+06F7w6kDQyCfrrfvZrv+yjnjPaSqDKlGFRMwybvy0NdhKvi2/nZBJBQgOQdDZ8xM0BzULDMDlfl8iZKr8+Gj/zHuHjVhVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CwST5qVl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CwST5qVl"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50K7WrYn010729;
	Mon, 20 Jan 2025 10:34:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jd7i6Y
	iwFiEHjE+qMhmrOH/TLgCzmSVlgtsuVK11PBA=; b=CwST5qVl6/sMQRAbriI/f4
	M/nXHdydb7YraRuV544J9HoIFEMfnjE8OdVff36YaKIQxZ7fRQ23DaPl3U3MQP2d
	gwYeRb8dEsPSlRdx2N6B/U+ebxRLJnQIw8ih1HI0lebYRXmOmTfFZj4ZVpKbBrsq
	XlCHQMt9WI+s9NJaab9X3df+jMSdl7nyPgIiZ7ci+KS7M6Ex1Mh0UANgTtOWSYpV
	SzA5JPlvzIBSRAee/fQWJ3ztJoo7jcGryDrhdZsY14TqAuoxZPDlzjbcTBBCqjYm
	cmHEfbDRokPwIVkLgq7S8eVYeQDeHMSJ9uRrCD0ff6q0HIv3b1xIXQZJj9dz6b8Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 449j6n8tkw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 10:34:28 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50KAYRvT003838;
	Mon, 20 Jan 2025 10:34:27 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 449j6n8tku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 10:34:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50K846J6022387;
	Mon, 20 Jan 2025 10:34:27 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448r4jwsmf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 10:34:27 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50KAYQTx8192752
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jan 2025 10:34:26 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F357858063;
	Mon, 20 Jan 2025 10:34:25 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 31FFB58062;
	Mon, 20 Jan 2025 10:34:22 +0000 (GMT)
Received: from [9.179.12.37] (unknown [9.179.12.37])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jan 2025 10:34:22 +0000 (GMT)
Message-ID: <ab6bef6ce04c9ddcbf22a2d0b42180ca343839bf.camel@linux.ibm.com>
Subject: Re: [RFC net-next 4/7] net/ism: Add kernel-doc comments for ism
 functions
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: dust.li@linux.alibaba.com, Alexandra Winter <wintera@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
        Gerd
 Bayer <gbayer@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        "D.
 Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu	 <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Peter Oberparleiter
 <oberpar@linux.ibm.com>,
        David Miller <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Julian Ruess <julianr@linux.ibm.com>,
        Thorsten Winkler	
 <twinkler@linux.ibm.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily
 Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle
 <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>
Date: Mon, 20 Jan 2025 11:34:21 +0100
In-Reply-To: <20250120063241.GM89233@linux.alibaba.com>
References: <20250115195527.2094320-1-wintera@linux.ibm.com>
	 <20250115195527.2094320-5-wintera@linux.ibm.com>
	 <20250120063241.GM89233@linux.alibaba.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: A7koCo9wpCZpkzwSx-seFgcxntWgU4YL
X-Proofpoint-ORIG-GUID: ygrGKvp3kA4d37KEWd72DMG9zoVJ9Nc4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-20_02,2025-01-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501200087

On Mon, 2025-01-20 at 14:32 +0800, Dust Li wrote:
> On 2025-01-15 20:55:24, Alexandra Winter wrote:
> > Note that in this RFC this patch is not complete, future versions
> > of this patch need to contain comments for all ism_ops.
> > Especially signal_event() and handle_event() need a good generic
> > description.
> >=20
> > Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
> > ---
> > include/linux/ism.h | 115 ++++++++++++++++++++++++++++++++++++++++----
> > 1 file changed, 105 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/include/linux/ism.h b/include/linux/ism.h
> > index 50975847248f..bc165d077071 100644
> > --- a/include/linux/ism.h
> > +++ b/include/linux/ism.h
> > @@ -13,11 +13,26 @@
> > #include <linux/workqueue.h>
> > #include <linux/uuid.h>
> >=20
> > -/* The remote peer rgid can use dmb_tok to write into this buffer. */
> > +/*
> > + * DMB - Direct Memory Buffer
> > + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > + * An ism client provides an DMB as input buffer for a local receiving
> > + * ism device for exactly one (remote) sending ism device. Only this
> > + * sending device can send data into this DMB using move_data(). Sende=
r
> > + * and receiver can be the same device.
> > + * TODO: Alignment and length rules (CPU and DMA). Device specific?
> > + */
> > struct ism_dmb {
> > +	/* dmb_tok - Token for this dmb
> > +	 * Used by remote sender to address this dmb.
> > +	 * Provided by ism fabric in register_dmb().
> > +	 * Unique per ism fabric.
> > +	 */
> > 	u64 dmb_tok;
> > +	/* rgid - GID of designated remote sending device */
> > 	u64 rgid;
> > 	u32 dmb_len;
> > +	/* sba_idx - Index of this DMB on this receiving device */
> > 	u32 sba_idx;
> > 	u32 vlan_valid;
> > 	u32 vlan_id;
> > @@ -25,6 +40,8 @@ struct ism_dmb {
> > 	dma_addr_t dma_addr;
> > };
> >=20
> > +/* ISM event structure (currently device type specific) */
> > +// TODO: Define and describe generic event properties
> > struct ism_event {
> > 	u32 type;
> > 	u32 code;
> > @@ -33,38 +50,89 @@ struct ism_event {
> > 	u64 info;
> > };
> >=20
> > +//TODO: use enum typedef
> > #define ISM_EVENT_DMB	0
> > #define ISM_EVENT_GID	1
> > #define ISM_EVENT_SWR	2
> >=20
> > struct ism_dev;
> >=20
> > +/*
> > + * ISM clients
> > + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > + * All ism clients have access to all ism devices
> > + * and must provide the following functions to be called by
> > + * ism device drivers:
> > + */
> > struct ism_client {
> > +	/* client name for logging and debugging purposes */
> > 	const char *name;
> > +	/**
> > +	 *  add() - add an ism device
> > +	 *  @dev: device that was added
> > +	 *
> > +	 * Will be called during ism_register_client() for all existing
> > +	 * ism devices and whenever a new ism device is registered.
> > +	 * *dev is valid until ism_client->remove() is called.
> > +	 */
> > 	void (*add)(struct ism_dev *dev);
> > +	/**
> > +	 * remove() - remove an ism device
> > +	 * @dev: device to be removed
> > +	 *
> > +	 * Will be called whenever an ism device is unregistered.
> > +	 * Before this call the device is already inactive: It will
> > +	 * no longer call client handlers.
> > +	 * The client must not access *dev after this call.
> > +	 */
> > 	void (*remove)(struct ism_dev *dev);
> > +	/**
> > +	 * handle_event() - Handle control information sent by device
> > +	 * @dev: device reporting the event
> > +	 * @event: ism event structure
> > +	 */
> > 	void (*handle_event)(struct ism_dev *dev, struct ism_event *event);
> > -	/* Parameter dmbemask contains a bit vector with updated DMBEs, if se=
nt
> > -	 * via ism_move_data(). Callback function must handle all active bits
> > -	 * indicated by dmbemask.
> > +	/**
> > +	 * handle_irq() - Handle signalling of a DMB
> > +	 * @dev: device owns the dmb
> > +	 * @bit: sba_idx=3Didx of the ism_dmb that got signalled
> > +	 *	TODO: Pass a priv pointer to ism_dmb instead of 'bit'(?)
> > +	 * @dmbemask: ism signalling mask of the dmb
> > +	 *
> > +	 * Handle signalling of a dmb that was registered by this client
> > +	 * for this device.
> > +	 * The ism device can coalesce multiple signalling triggers into a
> > +	 * single call of handle_irq(). dmbemask can be used to indicate
> > +	 * different kinds of triggers.
> > 	 */
> > 	void (*handle_irq)(struct ism_dev *dev, unsigned int bit, u16 dmbemask=
);
> > -	/* Private area - don't touch! */
> > +	/* client index - provided by ism layer */
> > 	u8 id;
> > };
> >=20
> > int ism_register_client(struct ism_client *client);
> > int  ism_unregister_client(struct ism_client *client);
> >=20
> > +//TODO: Pair descriptions with functions
> > +/*
> > + * ISM devices
> > + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > + */
> > /* Mandatory operations for all ism devices:
> >  * int (*query_remote_gid)(struct ism_dev *dev, uuid_t *rgid,
> >  *	                   u32 vid_valid, u32 vid);
> >  *	Query whether remote GID rgid is reachable via this device and this
> >  *	vlan id. Vlan id is only checked if vid_valid !=3D 0.
> > + *	Returns 0 if remote gid is reachable.
> >  *
> >  * int (*register_dmb)(struct ism_dev *dev, struct ism_dmb *dmb,
> >  *			    void *client);
> > - *	Register an ism_dmb buffer for this device and this client.
> > + *	Allocate and register an ism_dmb buffer for this device and this cl=
ient.
> > + *	The following fields of ism_dmb must be valid:
> > + *	rgid, dmb_len, vlan_*; Optionally:requested sba_idx (non-zero)
> > + *	Upon return the following fields will be valid: dmb_tok, sba_idx
> > + *		cpu_addr, dma_addr (if applicable)
> > + *	Returns zero on success
> >  *
> >  * int (*unregister_dmb)(struct ism_dev *dev, struct ism_dmb *dmb);
> >  *	Unregister an ism_dmb buffer
> > @@ -81,10 +149,15 @@ int  ism_unregister_client(struct ism_client *clie=
nt);
> >  * u16 (*get_chid)(struct ism_dev *dev);
> >  *	Returns ism fabric identifier (channel id) of this device.
> >  *	Only devices on the same ism fabric can communicate.
> > - *	chid is unique per HW system, except for 0xFFFF, which denotes
> > - *	an ism_loopback device that can only communicate with itself.
> > - *	Use chid for fast negative checks, but only query_remote_gid()
> > - *	can give a reliable positive answer.
> > + *	chid is unique per HW system. Use chid for fast negative checks,
> > + *	but only query_remote_gid() can give a reliable positive answer:
> > + *	Different chid: ism is not possible
> > + *	Same chid: ism traffic may be possible or not
> > + *		   (e.g. different HW systems)
> > + *	EXCEPTION: A value of 0xFFFF denotes an ism_loopback device
> > + *		that can only communicate with itself. Use GID or
> > + *		query_remote_gid()to determine whether sender and
> > + *		receiver use the same ism_loopback device.
> >  *
> >  * struct device* (*get_dev)(struct ism_dev *dev);
> >  *
> > @@ -109,6 +182,28 @@ struct ism_ops {
> > 	int (*register_dmb)(struct ism_dev *dev, struct ism_dmb *dmb,
> > 			    struct ism_client *client);
> > 	int (*unregister_dmb)(struct ism_dev *dev, struct ism_dmb *dmb);
> > +	/**
> > +	 * move_data() - write into a remote dmb
> > +	 * @dev: Local sending ism device
> > +	 * @dmb_tok: Token of the remote dmb
> > +	 * @idx: signalling index
> > +	 * @sf: signalling flag;
> > +	 *      if true, idx will be turned on at target ism interrupt mask
> > +	 *      and target device will be signalled, if required.
> > +	 * @offset: offset within target dmb
> > +	 * @data: pointer to data to be sent
> > +	 * @size: length of data to be sent
> > +	 *
> > +	 * Use dev to write data of size at offset into a remote dmb
> > +	 * identified by dmb_tok. Data is moved synchronously, *data can
> > +	 * be freed when this function returns.
>=20
> When considering the API, I found this comment may be incorrect.
>=20
> IIUC, in copy mode for PCI ISM devices, the CPU only tells the
> device to perform a DMA copy. As a result, when this function returns,
> the device may not have completed the DMA copy.

For the s390 ISM device the statement is true. The move_data() function
does a PCI Store Block instruction which is both the write on the
sender side but also synchronously acts as the devices DMA write on the
receiver side. So when the PCI Store Block instruction completes the
data has been cache coherently written to the receiver DMB. And yes
full synchronicity would be impossible with the posted writes of real
PCIe.

That said when it comes to API design I think you have a great point
here in that we need to decide if this synchronicity should be baked
into the move_data() API. I think we instead want to only guarantee a
weaker rule. That is the source buffer can be re-used after the move.
This to me is also aligned with the word "move" here in that the data
has been moved after the call not registered to be moved or such. This
could be achieved with a real PCIe device by copying the data or by
waiting on completion. If we ever get devices which need to wait on
completion it may indeed be better to have a separate completion step
in the API too. Then again I think the concept of having a single "move
data" step is somewhat central to ISM and I'd hate to lose that
simplicity.

I've been thinking also about a possible copy mode in a virtio-ism.
That could be useful if we wanted to use virtio-ism between memory
partitioned guests, or if one wanted to transparently proxy virtio-ism
over s390 ISM to span multiple KVM hosts. And I think such a mode could
still work with a single "move data" step and I'd love to have that in
any future virtio-ism spec.

>=20
> In zero-copy mode for loopback, the source and destination share the
> same buffer. If the source rewrites the buffer, the destination may
> encounter corrupted data. The source should only reuse the data after
> the destination has finished reading it.

I think there are two potential overwrite scenarios here.

1. The sender re-uses the source data buffer i.e. the @data buffer of
the move_data() call. On s390 ISM this is fine because the data was
copied out and into the destination DMB during the call. This could
typically become an issue if the device DMA reads directly from @data
after the move_data() call completed.

2. The sender does subsequent move_data() overwriting data in the
destination DMB before the receiver has read the data. This can happen
on s390 ISM too and needs to be prevented by DMB access rules.

For the move_data() call I think that even in a "shared i.e. same page
DMB" scenario move_data() must still do a copy out of the @data buffer
into the shared DMB. Otherwise it really wouldn't "move" data and it
would be a very weird API since @data is just a buffer not some kind of
descriptor. In other words I think scenario 1 shouldn't be possible in
either copy or shared DMB mode by the semantics of move_data().

>=20
> > +	 *
> > +	 * If signalling flag (sf) is true, bit number idx bit will be
> > +	 * turned on in the ism signalling mask, that belongs to the
> > +	 * target dmb, and handle_irq() of the ism client that owns this
> > +	 * dmb will be called, if required. The target device may chose to
> > +	 * coalesce multiple signalling triggers.
> > +	 */
> > 	int (*move_data)(struct ism_dev *dev, u64 dmb_tok, unsigned int idx,
> > 			 bool sf, unsigned int offset, void *data,
> > 			 unsigned int size);
> > --=20
> > 2.45.2
> >=20

