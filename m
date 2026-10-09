Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691A73E3D8B
	for <linux-s390@vger.kernel.org>; Fri,  9 Oct 2026 20:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791578891; cv=none; b=q18Q121zATXKX0wbEBiE0CFk6ModEjeKNmS992jFp0ybPrLFSpP8r+CqIhPQKAyf/jtPt5zdTlQb8W164ZIG88hddURjCxSo5+ooPaz+c1zgPpMhftP7fcBmVLlsAF4+dLbKDbhheeM5nATX2ZE5wCCoKDtYCzy729D60nwDy9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791578891; c=relaxed/simple;
	bh=uZnj9pcnbvugWs4gCTt69yNWJ8+6GdvaZtv/RdmlLHQ=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=tR7VAxKkRRxPgLBSSKaE2kMnKybD1jmpmbSRuxoCtZP9QzXLYwlZ91859LB6/+KpMwr/mLDzCyYK1GgLyiG7FRRw6zU7V6UduQWOA/yvg7MiQuU5j1Kp4xvFnUtr5anSWRvz38OwdHaDJNlJysOZBiBsLwHsaxZkhTPGN3HiFf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FuOhBc3w; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FuOhBc3w"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699K5UoH4022567
	for <linux-s390@vger.kernel.org>; Fri, 9 Oct 2026 20:48:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LITws3
	lzy+IP4hYdvmmMVkHUTBPOrwdsySLLo4bM4GQ=; b=FuOhBc3wUDQMtMDWpkwmwE
	GLX7k38Zw9bx3aqslPfUHlGFnVvlxZBjAqYW7p/b9bpweAgaDhtcRX1a+14Q0KFA
	y+Jg58vFucRH14HNnJ3AND2T1tTaWjOCQ0+CJOcTBe//yxBq1yJSzarAewUPJ5C4
	WQMsxSpm2FKDCXcQvOg3J81bQ0ulMnstP39dVh9SRi84MIh3BEuZnjgwU4i9A9aU
	h4hSSaYkeTWbuXfGgnkAJzPHiJD/p+n4OGIY/Munci3pKBFgrzK944VbXERK6pQG
	HFmL4jGXeKXbPHwdceZWknWpVFQi+49IniAAiEg9bGsWOcLcT1liCscbfKRVOseA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h74tersgh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 09 Oct 2026 20:48:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 699K3J1Q1361243
	for <linux-s390@vger.kernel.org>; Fri, 9 Oct 2026 20:48:07 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h6v76tksf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 09 Oct 2026 20:48:07 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 699Km4Hh29229648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 20:48:04 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BDCD5804E;
	Fri,  9 Oct 2026 20:48:04 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E66958056;
	Fri,  9 Oct 2026 20:48:01 +0000 (GMT)
Received: from [9.87.138.145] (unknown [9.87.138.145])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 20:48:01 +0000 (GMT)
Message-ID: <f91dbf8597ac93e245d55c7ef7d7a1bd63026d60.camel@linux.ibm.com>
Subject: Re: [PATCH 1/4] dibs: introduce ring-buffer send/receive API
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Julian Ruess <julianr@linux.ibm.com>, wintera@linux.ibm.com,
        ts@linux.ibm.com, oberpar@linux.ibm.com, gbayer@linux.ibm.com
Cc: mjrosato@linux.ibm.com, alifm@linux.ibm.com, raspl@linux.ibm.com,
        hca@linux.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org
In-Reply-To: <20261008-console_server-v1-1-636b11ebf191@linux.ibm.com>
References: <20261008-console_server-v1-0-636b11ebf191@linux.ibm.com>
	 <20261008-console_server-v1-1-636b11ebf191@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 22:47:00 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FV9DECECE1PgofhvdFkU83pG8wV91KqZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA4MiBTYWx0ZWRfXwlmeyLTsBNf9
 czvma1fAKOfP0lCJhUnpIw2nrmGngRQOvkoz1eT/kopRnU+Yg8D/5Zx3ZZBLqCa7Knxl+87jhYB
 1CuwNASzVqYyJjhIPmyNrdmo8UvzQZjSG5GbY/0/WJA0FghG47ego8x+2FWKEboN+20HH3GDPAa
 /SUehEav6022T1dR1X96ZwuQwtgJXAK21gtnG/50xIPTzKTldW797QLYuvImtGx3K1bVBKcMWw3
 4m9ZkkxBoZF473LYgo1mg7BMa6UGXlOwLrRZruWisSt2ldj6Y/zE1dLe31Gm3hvGDh1eAmHtsHq
 5A0YXc36GUWNJTTmUSW7+h1L+Me6mTH8JKtirn13LCpSfv1tIWtY15NlkE3M8RWKOtHWiYzm5B0
 S3/IMAncygNQ3fHQg9Vl0hVWBEg3nLowXfI18JRWREEkZcBYM4hbwHSYXGTYtVQbOvCPwmjNq7o
 djWRLcNz7lBOI38i7Ag==
X-Proofpoint-GUID: FV9DECECE1PgofhvdFkU83pG8wV91KqZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA4MiBTYWx0ZWRfX3qmJ6hhP+U2B
 9KJLNoHH+79lm76aGBJ2Uy3Yp/4qA4LMMATc1DtDhB47vxl6tVc4SnWA7FagBrfj5qHZ1FAS7j4
 UVKdmapM6gguHottV7nKPkLObKbsqoY=
X-Authority-Analysis: v=2.4 cv=Nf1zRGD4 c=1 sm=1 tr=0 ts=6ac95308 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=rHkkQgYglAlomXS9uNYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090082

On Thu, 2026-10-08 at 10:08 +0200, Julian Ruess wrote:
> From: Tobias Schumacher <ts@linux.ibm.com>
>=20
> Introduce a centralized API for sending and receiving data between dibs
> peers via ring buffers. With this API, drivers no longer need to
> interact directly with DMBs and manage read/write pointers.
>=20
> A driver must first register its ring buffer using
> dibs_register_ring_buffer() and set the rdmb_tok via
> dibs_ring_set_rdmb_tok(). After that, data can be sent using
> dibs_ring_send().
>=20
> Receiving messages is split into two steps: dibs_ring_recv() returns a
> pointer to the next DIBS message if one is available. After the message
> is processed, dibs_ring_ack() must be called to free up the message
> buffers and to advance the read pointer. If no message is available,
> dibs_ring_recv() returns NULL.

I think this commit message could provide a few more details on the
functioning of the ring, it's data layout and parts (e.g.
rd_dmb/wr_dmb/meta_dmb), constraints (like power of 2) and how the data
transfers work with respect to the head/tail pointers (i.e. refer to
the CIRC_=E2=80=A6 macros) and where what part resides. Quite a bit of this=
 is
in the comments in the header but reading this patch from the start I
only noticed late and would really have liked more of it in the commit
message. Also I think there should be a section on how
recovery/reconnect works.

I'm still torn about whether it would make sense to put this in
Documentation/dibs/ where its existence is also easier to pick out from
the change stats. I believe in earlier internal discussions I was
favoring comments and commit messages but since this has grown in
complexity and I think a documentation file would be nice.

>=20
> Co-developed-by: Julian Ruess <julianr@linux.ibm.com>
> Signed-off-by: Julian Ruess <julianr@linux.ibm.com>
> Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
> ---
>  drivers/dibs/dibs_main.c | 493 +++++++++++++++++++++++++++++++++++++++++=
+++++-
>  include/linux/dibs.h     |  99 ++++++++++
>  2 files changed, 590 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/dibs/dibs_main.c b/drivers/dibs/dibs_main.c
> index 20c50997a7cf..e3a33bc42fe8 100644
> --- a/drivers/dibs/dibs_main.c
> +++ b/drivers/dibs/dibs_main.c
> @@ -13,6 +13,9 @@
>  #include <linux/slab.h>
>  #include <linux/err.h>
>  #include <linux/dibs.h>
> +#include <linux/circ_buf.h>
> +#include <linux/log2.h>
> +#include <asm/barrier.h>
> =20
>  #include "dibs_loopback.h"
> =20
> @@ -20,7 +23,7 @@ MODULE_DESCRIPTION("Direct Internal Buffer Sharing clas=
s");
>  MODULE_LICENSE("GPL");
> =20
>  static const struct class dibs_class =3D {
> -	.name		=3D "dibs",
> +	.name =3D "dibs",
>  };
> =20
>  /* use an array rather a list for fast mapping: */
> @@ -93,7 +96,8 @@ int dibs_unregister_client(struct dibs_client *client)
>  		max_dmbs =3D dibs->ops->max_dmbs();
>  		for (int i =3D 0; i < max_dmbs; ++i) {
>  			if (dibs->dmb_clientid_arr[i] =3D=3D client->id) {
> -				WARN(1, "%s: attempt to unregister '%s' with registered dmb(s)\n",
> +				WARN(1,
> +				     "%s: attempt to unregister '%s' with registered dmb(s)\n",

Nit: This line as well as the change in dibs_class look like overly
eager auto format instead of an actual change. This is one of the
reasons I personally only do auto format over selected lines in my
editor and no auto format on save. Also I'd keep the above literal in
one line with the WARN().

>  				     __func__, client->name);
>  				rc =3D -EBUSY;
>  				goto err_reg_dmb;
> @@ -245,6 +249,491 @@ void dibs_dev_del(struct dibs_dev *dibs)
>  }
>  EXPORT_SYMBOL_GPL(dibs_dev_del);
> =20
> +/**
> + * dibs_ring_peer_meta() - take a snapshot of the peer's ring metadata
> + * @rb: pointer to the ring buffer
> + * @peer: snapshot to fill in
> + *
> + * The peer writes its metadata dmb at any time, so read each field once=
 and
> + * copy to the snapshot.
> + */
> +static void dibs_ring_peer_meta(struct dibs_ring_buffer *rb,
> +				struct dibs_ring_meta *peer)
> +{
> +	peer->meta_dmb_tok =3D READ_ONCE(rb->rd_ring_meta->meta_dmb_tok);
> +	peer->buff_dmb_tok =3D READ_ONCE(rb->rd_ring_meta->buff_dmb_tok);
> +	peer->size =3D READ_ONCE(rb->rd_ring_meta->size);
> +	peer->head =3D READ_ONCE(rb->rd_ring_meta->head);
> +	peer->tail =3D READ_ONCE(rb->rd_ring_meta->tail);
> +	peer->reserved =3D 0;
> +}
> +
> +static int dibs_ring_send_hdr(struct dibs_ring_buffer *rb, u64 meta_dmb_=
tok)
> +{
> +	int res;
> +
> +	if (!meta_dmb_tok)
> +		return 0;
> +
> +	res =3D rb->dibs->ops->move_data(rb->dibs, meta_dmb_tok, 0, true, 0,
> +				       &rb->wr_ring_meta,
> +				       sizeof(struct dibs_ring_meta));
> +

Nit: Stray empty line

> +	if (!res)
> +		rb->hdr_sent =3D true;
> +
> +	return res;
> +}
> +
> +/**
> + * dibs_ring_register() - register a DIBS ring buffer
> + * @name: name of the ring buffer. This will be used in debug output to
> + *        support identifying the ring buffer.
> + * @rb: pointer to the ring buffer struct. The fields in the struct don'=
t have
> + *      to be initialized.
> + * @client: pointer to the DIBS client
> + * @dibs: pointer to the DIBS device
> + * @rgid: the remote GID that will be allowed to write into this ring bu=
ffer
> + * @size: size of the ring buffer in bytes
> + *
> + * Register and initialize a DIBS ring buffer. Allocates the metadata DM=
B and
> + * the payload DMB, initializes the fields in dibs_ring_buffer.
> + *
> + * Return: 0 in case of success, an error code in case of failure
> + */
> +int dibs_ring_register(char *name, struct dibs_ring_buffer *rb,
> +		       struct dibs_client *client, struct dibs_dev *dibs,
> +		       uuid_t rgid, u32 size)
> +{
> +	int ret;
> +
> +	if (!size || !is_power_of_2(size))
> +		return -EINVAL;
> +
> +	strscpy(rb->name, name, sizeof(rb->name));
> +	rb->dibs =3D dibs;
> +	rb->dmb.rgid =3D rgid;
> +
> +	rb->rd_meta_dmb.dmb_len =3D ALIGN(sizeof(struct dibs_ring_meta), 4096);
> +	rb->rd_meta_dmb.rgid =3D rgid;
> +	ret =3D dibs->ops->register_dmb(dibs, &rb->rd_meta_dmb, client);
> +	if (ret)
> +		return ret;
> +
> +	rb->dmb.dmb_len =3D ALIGN(size, 4096);

Nit: The two DMB registrations would be easier to read if the dmb.rgid
was set here just like it is done for the rd_meta_dmb.rgid above and
how the dmb.dmb_len is only set here.

> +	ret =3D dibs->ops->register_dmb(dibs, &rb->dmb, client);
> +	if (ret) {
> +		dibs->ops->unregister_dmb(rb->dibs, &rb->rd_meta_dmb);
> +		return ret;
> +	}
> +
> +	rb->dmb_registered =3D 1;
> +
> +	rb->wr_ring_meta.meta_dmb_tok =3D rb->rd_meta_dmb.dmb_tok;
> +	rb->wr_ring_meta.buff_dmb_tok =3D rb->dmb.dmb_tok;
> +	rb->wr_ring_meta.size =3D size;
> +	rb->wr_ring_meta.head =3D 0;
> +	rb->wr_ring_meta.tail =3D 0;
> +	rb->wr_ring_meta.reserved =3D 0;
> +
> +	rb->rd_ring_meta =3D rb->rd_meta_dmb.cpu_addr;
> +	rb->peer_buff_dmb_tok =3D 0;
> +	rb->msg_size =3D 0;
> +	rb->hdr_sent =3D false;
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(dibs_ring_register);
> +
> +/**
> + * dibs_ring_unregister() - unregister a DIBS ring buffer
> + * @rb: pointer to the ring buffer to unregister
> + *
> + * Free the resources allocated by dibs_ring_register().
> + *
> + * Return: 0 in case of success, an error code in case of failure
> + */
> +int dibs_ring_unregister(struct dibs_ring_buffer *rb)
> +{
> +	struct dibs_ring_meta peer;
> +	int ret;
> +
> +	rb->wr_ring_meta.meta_dmb_tok =3D 0;
> +	rb->wr_ring_meta.buff_dmb_tok =3D 0;
> +	rb->wr_ring_meta.size =3D 0;
> +	rb->wr_ring_meta.head =3D 0;
> +	rb->wr_ring_meta.tail =3D 0;
> +
> +	dibs_ring_peer_meta(rb, &peer);
> +	if (peer.meta_dmb_tok) {
> +		ret =3D dibs_ring_send_hdr(rb, peer.meta_dmb_tok);
> +		if (ret)
> +			pr_warn("%s: failed to send header update: %d\n",
> +				__func__, ret);
> +	}

I think the function doc should mention that this sends a final header
update and explain why this is and what it looks like,

> +
> +	ret =3D rb->dibs->ops->unregister_dmb(rb->dibs, &rb->dmb);
> +	if (ret)
> +		pr_warn("%s: failed to unregister payload dmb: %d\n", __func__,
> +			ret);
> +
> +	ret =3D rb->dibs->ops->unregister_dmb(rb->dibs, &rb->rd_meta_dmb);
> +	if (ret)
> +		pr_warn("%s: failed to unregister metadata dmb: %d\n", __func__,
> +			ret);
> +
> +	rb->dmb_registered =3D 0;
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(dibs_ring_unregister);
> +
> +/**
> + * dibs_ring_peer_replaced() - check if the peer has replaced its ring b=
uffer
> + * @rb: pointer to the ring buffer
> + * @peer: snapshot of the peer's metadata
> + *
> + * The fabric hands out a new dmb token for every registration, so a buf=
fer
> + * token that differs from the one this side is synchronized to means th=
e peer
> + * ring this side writes into is a different one.

This function doc should mention under what circumstances this may be
the case. I'm assuming this only happens during recovery after a peer
was restarted/reconnected?  For more details this should probably be
part of the documentation and then the comment can refer to that.

> + *
> + * Return: true if the peer ring has been replaced, false otherwise
> + */
> +static bool dibs_ring_peer_replaced(struct dibs_ring_buffer *rb,
> +				    const struct dibs_ring_meta *peer)
> +{
> +	return peer->buff_dmb_tok !=3D rb->peer_buff_dmb_tok;
> +}
> +
> +/**
> + * dibs_ring_sync_peer() - synchronize with a replaced peer ring buffer
> + * @rb: pointer to the ring buffer
> + * @peer: snapshot of the peer's metadata
> + *
> + * Restart both pointers: head is this side's write position in the peer=
's
> + * buffer, which is a new and empty one, and tail is this side's read po=
sition
> + * in its own buffer, which the peer has started to write at offset 0 ag=
ain.
> + * Sends the updated metadata header to the peer and only then remembers=
 the
> + * new token, so that a failed send is retried on the next call.
> + *
> + * A peer that has torn its ring down is not synchronized to, it is only
> + * forgotten - this side cannot send anything until the peer registers a=
gain.

Same comment as above.

> + */
> +static void dibs_ring_sync_peer(struct dibs_ring_buffer *rb,
> +				const struct dibs_ring_meta *peer)
> +{
> +	if (!peer->buff_dmb_tok) {

Should the condition be a call to dibs_ring_peer_ready()?

> +		rb->wr_ring_meta.tail =3D 0;
> +		rb->peer_buff_dmb_tok =3D 0;
> +		rb->hdr_sent =3D false;
> +		return;
> +	}
> +
> +	rb->wr_ring_meta.head =3D 0;
> +	rb->wr_ring_meta.tail =3D 0;
> +
> +	if (dibs_ring_send_hdr(rb, peer->meta_dmb_tok)) {
> +		pr_warn("%s(%s): failed to send header after peer restart\n",
> +			__func__, rb->name);
> +		return;
> +	}
> +
> +	rb->peer_buff_dmb_tok =3D peer->buff_dmb_tok;
> +}
> +
--- snip ---
> =20
> +/* Ring Buffer Communication
> + * -------------------------
> + * Based on the DMBs, DIBS provides a ring buffer mechanism for bi-direc=
tional
> + * communication between two peers. For each ring-buffer connection, two=
 DMBs
> + * are allocated per peer:
> + * - one DMB holding metadata about the ring and
> + * - one DMB holding the actual data to be transferred.
> + *
> + * Metadata consists of parameters like the DMB tokens, size, head point=
er and
> + * tail pointer. Note that the metadata stored in the locally allocated
> + * metadata DMB does not necessarily corelate to the locally allocated p=
ayload
> + * DMB. As illustrated below, each peer has access to one wr_ring_meta D=
MB
> + * (the one the other peer has allocated) and one rd_ring_meta DMB (the =
one
> + * it has allocated itself). This is because the locally allocated DMB c=
an only
> + * be written by the other peer and vice versa.
> + *
> + * Peer A                   Peer B
> + * ---------------          ---------------
> + * wr_ring_meta ----------> rd_ring_meta
> + * rd_ring_meta <---------- wr_ring_meta
> + * send_buffer  ----------> recv_buffer
> + * recv_buffer  <---------- send_buffer
> + *
> + * Consider for example that peer A wants to send data to peer B. It fir=
st has
> + * to check how much data it previously has written (head pointer) and h=
ow far
> + * peer B has read (tail pointer) and compare this to the size. Since fo=
r send
> + * operations head is updated by peer A, it is located in the wr_ring_me=
ta DMB.
> + * Tail is updated by the receiving side, peer B in this case, so peer A=
 will
> + * find the current value in rd_ring_meta. The payload DMB was allocated=
 by
> + * peer B, so peer B also updated the size - peer A therefore finds the =
correct
> + * value in rd_ring_meta.
> + *
> + * Now peer a can write data into the send_buffer and update the head po=
inter
> + * in wr_ring_meta. Peer B then reads this head pointer from its rd_ring=
_meta
> + * DMB, process the data and update tail in its wr_ring_meta.
> + */

I saw this way too late going through the patch from top to bottom.
Then remembered that I had read this in an internal version where I
think I also saw it late. I think Documentation changes always get
sorted to the top and stand out in the stats so that's an argument for
adding docs I guess ;)

> +struct dibs_ring_meta {
> +	/* meta_dmb_tok - Token for the metadata dmb. */
> +	u64 meta_dmb_tok;
> +	/* buff_dmb_tok - Token for the buffer dmb */
> +	u64 buff_dmb_tok;
> +	/* size - size of the buffer for receiving data in number of byte */
> +	u32 size;
> +	/* head - points to the head of the ring buffer, i.e., the element
> +	 * that will be written next
> +	 */
> +	u32 head;
> +	/* tail - points to the end of the ring-buffer, i.e., the element
> +	 * that will be read next
> +	 */
> +	u32 tail;
> +	/* reserved - keeps the struct at its natural size, must be zero */
> +	u32 reserved;
> +};
> +
--- snip ---
>  /* Functions to be called by dibs device drivers:
> @@ -461,4 +554,10 @@ int dibs_dev_add(struct dibs_dev *dibs);
>   */
>  void dibs_dev_del(struct dibs_dev *dibs);
> =20
> +struct dibs_msg_hdr {
> +	u8 version;
> +	u8 type;
> +	u16 datalen;
> +} __packed;
> +
>  #endif	/* _DIBS_H */

I have so far only thoroughly read through a small part of the patch=20
so regard this as a set of first comments. I feel like it is already
actionable though so wanted to reply quickly rather than wait.=C2=A0

Overall I really like the abstraction and concept!

Thanks,
Niklas
