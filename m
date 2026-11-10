Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794332664;
	b=KzmLdY4j5IYyP6ZkmHiilR/iL7kFrXtQOSGYSSoxdbQpTbWWqmM+j+p8tZmOaPqofos8
	 3ezygjzKi7E7mnKzJdDFEmRNrnmaZ3boDvAJNO04qDePa6X0TP7JhBHDt4CCXoc2xuH5n
	 gOhHq2l3nKIFd8DmG80WXmvlg/d3W+U0Br1/EKqWW4CrzUTXFJJ7ARMWSCl4IKMa+DtF0
	 Y4ykCWFsaidDsmexn6xRfthyA7cb+eTo0FKPLBB/cQDinof22i4G5QC9/OaCXDqFVjZRA
	 ykDHEyxgcPoNbCjzyqoPbK/LfPZjpwpCO5EKP2geYMC9UarGfK79Xv+TQVn/yQ5M5ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794332664;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=TD7jgXIC8ZEoR3Q8Afgz5ZWvpzojIBnhOWry06iUeXo=;
	b=J8FbheTjr5xk2CM0mc/XT44Daf1G1545wcMIomee4SvPWK5r9azUlT+/OrKRqx+I29TI
	 lnxrjduKR36QoJHMeVwc2IImr9wQL5+x7EpDNppXBAyLyJA6NEsCmzyvmNGZdkc6D0MRi
	 Vj++KvXT6TPOWNdz9wanNXXsU+HosYgxdyhXaQAdR5J3OXQh/SWd0/GEDrX6ZJQ32HOfc
	 NWNew6ASWv6lEf48AL5RwQjW08dMdHDlCdo2TgYN9tiiKKF3UVBTw4Quv/Sb6MPouUKny
	 EqieqBFSXhgJRV/8pJB3enG9ZduPD7YozBrNDEO0BqNloE4hNL2kxpQgCdpyk0iyNgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZTS42aZj;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C4E606A33A
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 17:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8C4E606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZTS42aZj
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AAFEHp51449854
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 17:44:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TD7jgX
	IC8ZEoR3Q8Afgz5ZWvpzojIBnhOWry06iUeXo=; b=ZTS42aZjVL5FTRf999u2Vu
	JuU85KIfEL1WW9XNC5hxKJ3DHb7eB4Iu89lJpSJ1zfbu67wOktyPVtxin7Hqe8Z+
	g71FnYDDMtB8GS1LX7GJam6wFJ73mdC7KEZ4ULYG95iaQtCGOoP46AKTxBVXz28y
	0zMuNMpMii2b/zAhn3iztcgfyjNG82SHdcg4NU1M2vznIkNOCovMOdLhp9EPOvC6
	8H40ZQbahs6hO3l0FFl5T0uqD8pHpP3J5nOG5HCKdU8MCEZgjtnARHS2KWRGS72K
	2GpTYYqqTk8Ac61oFNwEgtiMeL+ctKPH1u+3oRwfY3LSBW+nq1GmAbrkmHdWosfg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hstdg5ta1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 17:44:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AAF52sl1925711
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 17:44:21 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hv309h588-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 17:44:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AAHiGnF31523214
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Nov 2026 17:44:16 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 801D420040;
	Tue, 10 Nov 2026 17:44:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 37B902004B;
	Tue, 10 Nov 2026 17:44:16 +0000 (GMT)
Received: from [9.68.31.53] (unknown [9.68.31.53])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Nov 2026 17:44:16 +0000 (GMT)
Message-ID: <1ded15e9-99bd-44ca-82c2-5bc63ede39c7@linux.ibm.com>
Date: Tue, 10 Nov 2026 18:44:16 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dibs: introduce ring-buffer send/receive API
To: Julian Ruess <julianr@linux.ibm.com>, schnelle@linux.ibm.com,
        ts@linux.ibm.com, oberpar@linux.ibm.com, gbayer@linux.ibm.com
Cc: mjrosato@linux.ibm.com, alifm@linux.ibm.com, raspl@linux.ibm.com,
        hca@linux.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org
References: <20261008-console_server-v1-0-636b11ebf191@linux.ibm.com>
 <20261008-console_server-v1-1-636b11ebf191@linux.ibm.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20261008-console_server-v1-1-636b11ebf191@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J+M/fwnS c=1 sm=1 tr=0 ts=6af357f6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=QS387uB5Y4WFtsIrWmAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA3MCBTYWx0ZWRfX6MaCEvhCz3nP
 qNOCKBExmyp0vgGrq2kx4PSWY9weGIV/Cj7Aiq9soB2pLVR0SeTAoaUks4sYFfdQTHRmiQoNJbw
 tYNTYIzXzysS3HDz/GB9sEfDWhYQlj6nV8MSg7ZdX0/FtJgNvI4NQy+b6J+Rbw8PwUHsDUVsedh
 nY7p/CFdJFYZLEziJcDyiMMsj+Ohx5AU7sy7RrdX7a/usthxlaR+v+U5l242V2JpKFd8Od18hDa
 tptSU7hD/vtOKMdDWOraTsiThTEyr0MTf9CaVZrMnBYLBsbgVxVutceX9WXTj4JsGX8/sqHFbav
 uKtIeMMxNFb8YLmc3GK0N8HgCgUdfxqZQP9VDDBG6HI7ncsEOR7mnNUmBC8zU+aN5XvHF7KEBgt
 Ph9YiCFExEjyzVvcFQszJP8+IAaOnv+9Qgv3jBq6jgjsV30np6ed7BhqGgmfnXKaZImkI/TkyB8
 B3CHgqgv0u0v4Y3K/2A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA3MCBTYWx0ZWRfX+mKFTEHoTdrq
 EPUuKcqSWL0grspXy/pPatWItjL0ndrayYVxoR5CZOTG9XNofJgAmFrKLzBWhaL6Yu0P5igRyeC
 qy82Ld3ADGJQveaevoG1OtMLNPt5I6I=
X-Proofpoint-GUID: BPoN4ZvByw7VqSZIQ5xdK3jZVcowmDgI
X-Proofpoint-ORIG-GUID: BPoN4ZvByw7VqSZIQ5xdK3jZVcowmDgI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100070


Note that I did not write the comments in any order :-S

On 08.10.26 10:08, Julian Ruess wrote:
> From: Tobias Schumacher <ts@linux.ibm.com>
> 
> Introduce a centralized API for sending and receiving data between dibs
> peers via ring buffers. With this API, drivers no longer need to
> interact directly with DMBs and manage read/write pointers.
> 
> A driver must first register its ring buffer using
> dibs_register_ring_buffer() and set the rdmb_tok via
> dibs_ring_set_rdmb_tok(). After that, data can be sent using
> dibs_ring_send().
> 
> Receiving messages is split into two steps: dibs_ring_recv() returns a
> pointer to the next DIBS message if one is available. After the message
> is processed, dibs_ring_ack() must be called to free up the message
> buffers and to advance the read pointer. If no message is available,
> dibs_ring_recv() returns NULL.
> 
> Co-developed-by: Julian Ruess <julianr@linux.ibm.com>
> Signed-off-by: Julian Ruess <julianr@linux.ibm.com>
> Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
> ---
>  drivers/dibs/dibs_main.c | 493 ++++++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/dibs.h     |  99 ++++++++++
>  2 files changed, 590 insertions(+), 2 deletions(-)
> 
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
>  
>  #include "dibs_loopback.h"
>  
> @@ -20,7 +23,7 @@ MODULE_DESCRIPTION("Direct Internal Buffer Sharing class");
>  MODULE_LICENSE("GPL");
>  
>  static const struct class dibs_class = {
> -	.name		= "dibs",
> +	.name = "dibs",
>  };
>  
>  /* use an array rather a list for fast mapping: */
> @@ -93,7 +96,8 @@ int dibs_unregister_client(struct dibs_client *client)
>  		max_dmbs = dibs->ops->max_dmbs();
>  		for (int i = 0; i < max_dmbs; ++i) {
>  			if (dibs->dmb_clientid_arr[i] == client->id) {
> -				WARN(1, "%s: attempt to unregister '%s' with registered dmb(s)\n",
> +				WARN(1,
> +				     "%s: attempt to unregister '%s' with registered dmb(s)\n",
>  				     __func__, client->name);
>  				rc = -EBUSY;
>  				goto err_reg_dmb;
> @@ -245,6 +249,491 @@ void dibs_dev_del(struct dibs_dev *dibs)
>  }
>  EXPORT_SYMBOL_GPL(dibs_dev_del);
>  

Don't do formatting changes in lines you don't touch otherwise. [1]



> +/**
> + * dibs_ring_peer_meta() - take a snapshot of the peer's ring metadata
> + * @rb: pointer to the ring buffer
> + * @peer: snapshot to fill in
> + *
> + * The peer writes its metadata dmb at any time, so read each field once and
> + * copy to the snapshot.
> + */
> +static void dibs_ring_peer_meta(struct dibs_ring_buffer *rb,
> +				struct dibs_ring_meta *peer)
> +{
> +	peer->meta_dmb_tok = READ_ONCE(rb->rd_ring_meta->meta_dmb_tok);
> +	peer->buff_dmb_tok = READ_ONCE(rb->rd_ring_meta->buff_dmb_tok);
> +	peer->size = READ_ONCE(rb->rd_ring_meta->size);
> +	peer->head = READ_ONCE(rb->rd_ring_meta->head);
> +	peer->tail = READ_ONCE(rb->rd_ring_meta->tail);
> +	peer->reserved = 0;
> +}
> +

Is this snapshotting really helpful/sufficient/necessary?
I guess you say that content of rd_ring_meta can change any time, but it
could even change inbetween the READ_ONCE calls.

Seems you call it before dibs_ring_peer_replaced(), is this any better
than to compare the current rd_ring_meta->buff_dmb_tok?

I guess there is a general question of validity of the meta buffers,
what if the other side changes and does not update its information in
rd_ring_meta atomically?
Maybe you need to define some rules?


> +static int dibs_ring_send_hdr(struct dibs_ring_buffer *rb, u64 meta_dmb_tok)
> +{
> +	int res;
> +
> +	if (!meta_dmb_tok)
> +		return 0;
> +
> +	res = rb->dibs->ops->move_data(rb->dibs, meta_dmb_tok, 0, true, 0,
> +				       &rb->wr_ring_meta,
> +				       sizeof(struct dibs_ring_meta));
> +
> +	if (!res)
> +		rb->hdr_sent = true;
> +
> +	return res;
> +}
> +
> +/**
> + * dibs_ring_register() - register a DIBS ring buffer
> + * @name: name of the ring buffer. This will be used in debug output to
> + *        support identifying the ring buffer.
> + * @rb: pointer to the ring buffer struct. The fields in the struct don't have
> + *      to be initialized.
> + * @client: pointer to the DIBS client
> + * @dibs: pointer to the DIBS device
> + * @rgid: the remote GID that will be allowed to write into this ring buffer
> + * @size: size of the ring buffer in bytes
> + *
> + * Register and initialize a DIBS ring buffer. Allocates the metadata DMB and
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
> +	rb->dibs = dibs;
> +	rb->dmb.rgid = rgid;
> +
> +	rb->rd_meta_dmb.dmb_len = ALIGN(sizeof(struct dibs_ring_meta), 4096);
> +	rb->rd_meta_dmb.rgid = rgid;
> +	ret = dibs->ops->register_dmb(dibs, &rb->rd_meta_dmb, client);
> +	if (ret)
> +		return ret;
> +
> +	rb->dmb.dmb_len = ALIGN(size, 4096);
> +	ret = dibs->ops->register_dmb(dibs, &rb->dmb, client);
> +	if (ret) {
> +		dibs->ops->unregister_dmb(rb->dibs, &rb->rd_meta_dmb);
> +		return ret;
> +	}
> +
> +	rb->dmb_registered = 1;
> +

Maybe add a comment that now the fields in wr_ring_meta (better name?)
are filled out for the remote side.

> +	rb->wr_ring_meta.meta_dmb_tok = rb->rd_meta_dmb.dmb_tok;
> +	rb->wr_ring_meta.buff_dmb_tok = rb->dmb.dmb_tok;
> +	rb->wr_ring_meta.size = size;
> +	rb->wr_ring_meta.head = 0;
> +	rb->wr_ring_meta.tail = 0;
> +	rb->wr_ring_meta.reserved = 0;
> +

How is this ever sent to the other side?
ok, I see that all kinds of functions call dibs_ring_send_hdr(), e.g.
dibs_ring_cnt().
Is there an recommended intital handshake sequence?

> +	rb->rd_ring_meta = rb->rd_meta_dmb.cpu_addr;
> +	rb->peer_buff_dmb_tok = 0;
> +	rb->msg_size = 0;
> +	rb->hdr_sent = false;
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
> +	rb->wr_ring_meta.meta_dmb_tok = 0;
> +	rb->wr_ring_meta.buff_dmb_tok = 0;
> +	rb->wr_ring_meta.size = 0;
> +	rb->wr_ring_meta.head = 0;
> +	rb->wr_ring_meta.tail = 0;
> +
> +	dibs_ring_peer_meta(rb, &peer);
> +	if (peer.meta_dmb_tok) {
> +		ret = dibs_ring_send_hdr(rb, peer.meta_dmb_tok);
> +		if (ret)
> +			pr_warn("%s: failed to send header update: %d\n",
> +				__func__, ret);

I'm not sure a warning is a good level here. What if the peer
unregisters at the same time (e.g. local and remote using same ism
device, or client using dibs_loopback ?) ? maybe pr_debug or pr_info?

> +	}
> +
> +	ret = rb->dibs->ops->unregister_dmb(rb->dibs, &rb->dmb);
> +	if (ret)
> +		pr_warn("%s: failed to unregister payload dmb: %d\n", __func__,
> +			ret);
> +
> +	ret = rb->dibs->ops->unregister_dmb(rb->dibs, &rb->rd_meta_dmb);
> +	if (ret)
> +		pr_warn("%s: failed to unregister metadata dmb: %d\n", __func__,
> +			ret);
> +
> +	rb->dmb_registered = 0;
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(dibs_ring_unregister);
> +
> +/**
> + * dibs_ring_peer_replaced() - check if the peer has replaced its ring buffer
> + * @rb: pointer to the ring buffer
> + * @peer: snapshot of the peer's metadata
> + *
> + * The fabric hands out a new dmb token for every registration, so a buffer
> + * token that differs from the one this side is synchronized to means the peer
> + * ring this side writes into is a different one.
> + *
> + * Return: true if the peer ring has been replaced, false otherwise
> + */
> +static bool dibs_ring_peer_replaced(struct dibs_ring_buffer *rb,
> +				    const struct dibs_ring_meta *peer)
> +{
> +	return peer->buff_dmb_tok != rb->peer_buff_dmb_tok;
> +}
> +

As mentioned above: Is it helpful/necessaryto compare against a snapshot?

You are checking this in dibs_ring_cnt, dibs_ring_recv and
dibs_ring_space() Why in these functions? What were your criteria?
Why are the other functions (like dibs_ring_cnt_to_end()) safe wihtout
this check?


> +/**
> + * dibs_ring_sync_peer() - synchronize with a replaced peer ring buffer
> + * @rb: pointer to the ring buffer
> + * @peer: snapshot of the peer's metadata
> + *
> + * Restart both pointers: head is this side's write position in the peer's
> + * buffer, which is a new and empty one, and tail is this side's read position
> + * in its own buffer, which the peer has started to write at offset 0 again.
> + * Sends the updated metadata header to the peer and only then remembers the
> + * new token, so that a failed send is retried on the next call.
> + *
> + * A peer that has torn its ring down is not synchronized to, it is only
> + * forgotten - this side cannot send anything until the peer registers again.
> + */

I'm not sure 'sync' is the best term. You reset the local read and write
pointers, becasue you assume the remote side has been replaced.
Thus it is fair to assume that its read and write pointers are also 0. (?)

'sync' sounds to me as if you could do it in a running system, but that
would break the accounting on the other side.

> +static void dibs_ring_sync_peer(struct dibs_ring_buffer *rb,
> +				const struct dibs_ring_meta *peer)
> +{
> +	if (!peer->buff_dmb_tok) {
> +		rb->wr_ring_meta.tail = 0;
> +		rb->peer_buff_dmb_tok = 0;
> +		rb->hdr_sent = false;
> +		return;
> +	}
> +
> +	rb->wr_ring_meta.head = 0;
> +	rb->wr_ring_meta.tail = 0;
> +
> +	if (dibs_ring_send_hdr(rb, peer->meta_dmb_tok)) {
> +		pr_warn("%s(%s): failed to send header after peer restart\n",
> +			__func__, rb->name);
> +		return;
> +	}
> +
> +	rb->peer_buff_dmb_tok = peer->buff_dmb_tok;
> +}
> +
> +/**
> + * dibs_ring_peer_ready() - check if the peer ring can be written to
> + * @peer: snapshot of the peer's metadata
> + *
> + * All of the peer's metadata is remote controlled. Its size is used as a mask
> + * for the head pointer and by the CIRC_* helpers, both of which require a
> + * power of two, so validate it before anything is derived from it.
> + *
> + * Return: true if the peer ring can be used, false otherwise
> + */
> +static bool dibs_ring_peer_ready(const struct dibs_ring_meta *peer)
> +{
> +	if (!peer->meta_dmb_tok || !peer->buff_dmb_tok)
> +		return false;
> +
> +	return is_power_of_2(peer->size);
> +}
> +
> +static size_t __dibs_ring_space(struct dibs_ring_buffer *rb,
> +				const struct dibs_ring_meta *peer)
> +{
> +	if (!dibs_ring_peer_ready(peer))
> +		return 0;
> +
> +	return CIRC_SPACE(rb->wr_ring_meta.head, peer->tail, peer->size);
> +}
> +
> +static size_t __dibs_ring_space_to_end(struct dibs_ring_buffer *rb,
> +				       const struct dibs_ring_meta *peer)
> +{
> +	if (!dibs_ring_peer_ready(peer))
> +		return 0;
> +
> +	return CIRC_SPACE_TO_END(rb->wr_ring_meta.head, peer->tail, peer->size);
> +}
> +
> +static u32 __dibs_ring_cnt(struct dibs_ring_buffer *rb,
> +			   const struct dibs_ring_meta *peer)
> +{
> +	return CIRC_CNT(peer->head, rb->wr_ring_meta.tail,
> +			rb->wr_ring_meta.size);
> +}
> +
> +static u32 __dibs_ring_cnt_to_end(struct dibs_ring_buffer *rb,
> +				  const struct dibs_ring_meta *peer)
> +{
> +	return CIRC_CNT_TO_END(peer->head, rb->wr_ring_meta.tail,
> +			       rb->wr_ring_meta.size);
> +}
> +
> +/**
> + * dibs_ring_space() - query the ring buffer's free space for sending
> + * @rb: pointer to the ring buffer
> + *
> + * Get the free space in the ring buffer that can be used for sending data.
> + * Automatically resynchronizes if the peer has replaced its ring.
> + *
> + * Return: the free space in the ring buffer

Would be nice, if the The 'Return:' statements of the following
fucntions were in the same style

Maybe: Return: Number of bytes that can be written into this rb

> + */
> +size_t dibs_ring_space(struct dibs_ring_buffer *rb)
> +{
> +	struct dibs_ring_meta peer;
> +
> +	dibs_ring_peer_meta(rb, &peer);
> +
> +	if (dibs_ring_peer_replaced(rb, &peer))
> +		dibs_ring_sync_peer(rb, &peer);
> +
> +	return __dibs_ring_space(rb, &peer);
> +}
> +
> +/**
> + * dibs_ring_space_to_end() - query the rb's space until the end of the DMB
> + * @rb: pointer to the ring buffer
> + *
> + * Get the free space in the ring buffer until the end of the underlying DMB.
> + * This is the amount of data that can be written without wrapping to the
> + * beginning of the DMB.
> + *
> + * Return: the free space in the ring buffer until the end of the DMB.

Maybe: Return: Number of consecutive writable bytes

> + */
> +size_t dibs_ring_space_to_end(struct dibs_ring_buffer *rb)
> +{
> +	struct dibs_ring_meta peer;
> +
> +	dibs_ring_peer_meta(rb, &peer);
> +
> +	return __dibs_ring_space_to_end(rb, &peer);
> +}
> +
> +/**
> + * dibs_ring_cnt() - query the ring buffer's fill state
> + * @rb: pointer to the ring buffer
> + *
> + * Get the number of bytes available in the ring buffer for reading.
> + * Automatically resynchronizes if the peer has replaced its ring.
> + *
> + * Return: fill state of the ring buffer

Maybe: Number of bytes that can be read from this rb

> + */
> +u32 dibs_ring_cnt(struct dibs_ring_buffer *rb)
> +{
> +	struct dibs_ring_meta peer;
> +
> +	dibs_ring_peer_meta(rb, &peer);
> +
> +	if (dibs_ring_peer_replaced(rb, &peer))
> +		dibs_ring_sync_peer(rb, &peer);
> +
> +	return __dibs_ring_cnt(rb, &peer);
> +}
> +
> +/**
> + * dibs_ring_cnt_to_end() - query the number of bytes in rb before wrap
> + * @rb: pointer to the ring buffer
> + *
> + * Get the number of bytes that can be read from the ring buffer without
> + * wrapping the tail pointer.
> + *
> + * Return: number of consecutive readable bytes
> + */
> +u32 dibs_ring_cnt_to_end(struct dibs_ring_buffer *rb)
> +{
> +	struct dibs_ring_meta peer;
> +
> +	dibs_ring_peer_meta(rb, &peer);
> +
> +	return __dibs_ring_cnt_to_end(rb, &peer);
> +}
> +
> +/**
> + * dibs_ring_set_rdmb_tok() - complete ring buffer token exchange
> + * @rb: pointer to the ring buffer
> + * @rdmb_tok: remote peer's metadata DMB token
> + *
> + * Completes the ring buffer setup by storing the remote peer's metadata DMB
> + * token and sending our local metadata to the peer. Normally, DMB tokens are

s/Normally, DMB tokens are/If available, DMB tokens are/g

> + * read from rd_meta_dmb, but this creates a circular dependency during initial
> + * setup (need the token to read the metadata that contains the token). To break

(need the remote meta dmb token to send my meta dmb token, so the remote
peer can send its meta dmb token)

You don't really need the token to read.

> + * this, one peer must receive the remote token through an alternative channel
> + * and call this function to send its own header as the initial handshake step.
> + * After this, both peers can read each other's metadata.
> + */

Please describe the initial handshake in dibs.h in "Ring Buffer
Communication".



> +void dibs_ring_set_rdmb_tok(struct dibs_ring_buffer *rb, u64 rdmb_tok)
> +{
> +	WRITE_ONCE(rb->rd_ring_meta->meta_dmb_tok, rdmb_tok);
> +	dibs_ring_send_hdr(rb, rdmb_tok);
> +}
> +EXPORT_SYMBOL_GPL(dibs_ring_set_rdmb_tok);
> +
> +/**
> + * dibs_ring_send() - Send DIBS message to peer
> + * @rb: Ring buffer to send message to
> + * @msg: Message to send
> + * @size: size of the message to be sent
> + * @notify: if true, update the remote's ring header and generate an IRQ after
> + *          sending.
> + *
> + * Send a DIBS message to the peer device using the specified ring buffer.
> + *
> + * Return: zero in case of success, an error code in case of failure
> + */
> +int dibs_ring_send(struct dibs_ring_buffer *rb, void *msg, u16 size,
> +		   bool notify)
> +{
> +	struct dibs_ring_meta peer;
> +	u32 old_head;
> +	int ret;
> +
> +	dibs_ring_peer_meta(rb, &peer);
> +
> +	if (!dibs_ring_peer_ready(&peer))
> +		return -EAGAIN;
> +
> +	if (__dibs_ring_space_to_end(rb, &peer) < size)
> +		return -ENOSPC;

??? This is a ring buffer, why can't you write and wrap??
How are you supposed to write and advance across the size??
This is not described in the description.

ok, I see pbd uses some weird padding jumps, so it never wraps inside a
message. But that should not be part of the ring_buffer design.

> +
> +	ret = rb->dibs->ops->move_data(rb->dibs, peer.buff_dmb_tok, 0, false,
> +				       rb->wr_ring_meta.head, msg, size);
> +	if (ret)
> +		return ret;
> +
> +	old_head = rb->wr_ring_meta.head;
> +	rb->wr_ring_meta.head = (old_head + size) & (peer.size - 1);
> +
> +	if (notify) {
> +		ret = dibs_ring_send_hdr(rb, peer.meta_dmb_tok);
> +		if (ret) {
> +			rb->wr_ring_meta.head = old_head;
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dibs_ring_send);
> +
> +/**
> + * dibs_ring_send_padding() - send padding data to ring buffer
> + * @rb: pointer to the ring buffer
> + * @size: number of bytes to send
> + *
> + * Advance the ring buffer's head pointer by size byte without actually
> + * writing any data into the data buffer. This can be used by higher level
> + * APIs to send padding data which shall be ignored by the receiving peer.
> + *
> + * Return: zero in case of success, an error code in case of failure
> + */
> +int dibs_ring_send_padding(struct dibs_ring_buffer *rb, u16 size)
> +{
> +	struct dibs_ring_meta peer;
> +	u32 old_head;
> +	int ret;
> +
> +	dibs_ring_peer_meta(rb, &peer);
> +
> +	if (!dibs_ring_peer_ready(&peer))
> +		return -EAGAIN;
> +
> +	if (__dibs_ring_space(rb, &peer) < size)
> +		return -ENOSPC;
> +
> +	old_head = rb->wr_ring_meta.head;
> +	rb->wr_ring_meta.head = (old_head + size) & (peer.size - 1);
> +
> +	ret = dibs_ring_send_hdr(rb, peer.meta_dmb_tok);
> +	if (ret) {
> +		rb->wr_ring_meta.head = old_head;
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dibs_ring_send_padding);
> +
> +/**
> + * dibs_ring_recv() - Receive message from DIBS ring buffer
> + * @rb: Ring buffer to get message from
> + *
> + * Get the next message from the ring buffer. After processing, the caller must
> + * call dibs_ring_ack() to update the ring buffer.
> + *
> + * Return: pointer to the DIBS message or NULL if the ring buffer is empty

s/DIBS/dibs/g

What is a dibs message?


> + */
> +void *dibs_ring_recv(struct dibs_ring_buffer *rb)
> +{
> +	struct dibs_ring_meta peer;
> +
> +	dibs_ring_peer_meta(rb, &peer);
> +
> +	if (unlikely(!rb->hdr_sent))
> +		dibs_ring_send_hdr(rb, peer.meta_dmb_tok);
> +
> +	if (dibs_ring_peer_replaced(rb, &peer))
> +		dibs_ring_sync_peer(rb, &peer);
> +
> +	if (!__dibs_ring_cnt(rb, &peer))
> +		return NULL;
> +
> +	/* pairs with the peer filling the payload before publishing head */
> +	dma_rmb();
> +
> +	return rb->dmb.cpu_addr + rb->wr_ring_meta.tail;
> +}
> +EXPORT_SYMBOL_GPL(dibs_ring_recv);
> +
> +/**
> + * dibs_ring_ack() - Acknowledge received message
> + * @rb: Ring buffer to operate on
> + *
> + * Acknowledges the message received by dibs_ring_recv(). This means, the read
> + * pointer in the ring buffer header is incremented and the updated header is
> + * sent to the remote side. 

Imperative: Acknowledge the message...increment the read pointer and
send the updated header..

After calling dibs_ring_ack(), the message structure
> + * returned by dibs_ring_recv() may be reused, so the driver must not use it

s/driver/caller/g

> + * anymore.
> + */

So you can only receive-ack one message after the other?
What if you receive 2 meessages and then ack? Probably a bad idea..
You may want to point that out somewhere.



> +int dibs_ring_ack(struct dibs_ring_buffer *rb, size_t size)
> +{
> +	struct dibs_ring_meta peer;
> +
> +	dibs_ring_peer_meta(rb, &peer);
> +
> +	if (size > __dibs_ring_cnt(rb, &peer)) {
> +		pr_warn("%s(%s, %lx): error: tail would overtake head\n",
> +			__func__, rb->name, size);
> +		return -EINVAL;
> +	}
> +
> +	rb->wr_ring_meta.tail = (rb->wr_ring_meta.tail + size) &
> +				(rb->wr_ring_meta.size - 1);
> +
> +	return dibs_ring_send_hdr(rb, peer.meta_dmb_tok);
> +}
> +EXPORT_SYMBOL_GPL(dibs_ring_ack);
> +
>  static int __init dibs_init(void)
>  {
>  	int rc;
> diff --git a/include/linux/dibs.h b/include/linux/dibs.h
> index 0c10c224bcca..30ae03484b58 100644
> --- a/include/linux/dibs.h
> +++ b/include/linux/dibs.h
> @@ -67,6 +67,83 @@ struct dibs_dmb {
>  	dma_addr_t dma_addr;
>  };
>  
> +/* Ring Buffer Communication
> + * -------------------------
> + * Based on the DMBs, DIBS provides a ring buffer mechanism for bi-directional
> + * communication between two peers. For each ring-buffer connection, two DMBs
> + * are allocated per peer:
> + * - one DMB holding metadata about the ring and
> + * - one DMB holding the actual data to be transferred.
> + *
> + * Metadata consists of parameters like the DMB tokens, size, head pointer and
> + * tail pointer. Note that the metadata stored in the locally allocated
> + * metadata DMB does not necessarily corelate to the locally allocated payload
> + * DMB. As illustrated below, each peer has access to one wr_ring_meta DMB
> + * (the one the other peer has allocated) and one rd_ring_meta DMB (the one
> + * it has allocated itself). This is because the locally allocated DMB can only
> + * be written by the other peer and vice versa.
> + *
> + * Peer A                   Peer B
> + * ---------------          ---------------
> + * wr_ring_meta ----------> rd_ring_meta
> + * rd_ring_meta <---------- wr_ring_meta
> + * send_buffer  ----------> recv_buffer
> + * recv_buffer  <---------- send_buffer
> + *
> + * Consider for example that peer A wants to send data to peer B. It first has
> + * to check how much data it previously has written (head pointer) and how far
> + * peer B has read (tail pointer) and compare this to the size. Since for send
> + * operations head is updated by peer A, it is located in the wr_ring_meta DMB.
> + * Tail is updated by the receiving side, peer B in this case, so peer A will
> + * find the current value in rd_ring_meta. The payload DMB was allocated by
> + * peer B, so peer B also updated the size - peer A therefore finds the correct
> + * value in rd_ring_meta.
> + *


I understand what you are doing, but I think the naming wr_ring_meta and
rd_ring_meta is very misleading. Would something like local_ring_meta
and remote_ring_meta be better to understand?

I guess you are saying the tail pointer fo a recv_buffer is in
wr_ring_meta together with the head pointer of the corresponding
send_buffer, right?


> + * Now peer a can write data into the send_buffer and update the head pointer
> + * in wr_ring_meta. Peer B then reads this head pointer from its rd_ring_meta
> + * DMB, process the data and update tail in its wr_ring_meta.
> + */
> +struct dibs_ring_meta {
> +	/* meta_dmb_tok - Token for the metadata dmb. */
> +	u64 meta_dmb_tok;


of this *_ring_meta or of the other *_ring_meta?


> +	/* buff_dmb_tok - Token for the buffer dmb */
> +	u64 buff_dmb_tok;

Of the send_buffer or of the recv_buffer?

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

Iiuc, tail is the tail pointer of the OTHER ringbuffer, right?


> +	/* reserved - keeps the struct at its natural size, must be zero */
> +	u32 reserved;
> +};
> +
> +struct dibs_ring_buffer {
> +	char name[256];
> +	struct dibs_dev *dibs;
> +	int dmb_registered;
> +	bool hdr_sent;

Add a comment that this is the dmb for recv_buffer

> +	struct dibs_dmb dmb;
> +	/* dmb for the ring metadata this side can read, peer can write */
> +	struct dibs_dmb rd_meta_dmb;
> +	/* ring metadata this side can write, peer can read */
> +	struct dibs_ring_meta wr_ring_meta;
> +	/* ring metadata this side can read, peer can write */
> +	struct dibs_ring_meta *rd_ring_meta;
> +	/* size validated by dibs_pbd_msg_recv(), acked by dibs_pbd_msg_ack() */

Is this msg_size really helpful??? Seems it is only used by pbd
functions in later patches. What is the intended mechanism?
Seems pbd uses it to remember the amount that should be ack'ed. Does
this make sense? What if a 2nd receive has overwritten it?
Are there any rules that need to be followed?

I think for the ringbuffer functions, I'd prefer not to store this here.
Caller should knwo how many bytes to ack.

> +	u32 msg_size;
> +	/* buff_dmb_tok of the peer ring this side is synchronized to. The
> +	 * fabric hands out a new token for every registration, so a different
> +	 * token means the peer has replaced its ring and the pointers into it
> +	 * are stale.
> +	 */
> +	u64 peer_buff_dmb_tok;

Naming? send_buffer_dmb_tok? To make it consistent with the drawing above?


> +};
> +
>  /* DIBS events
>   * -----------
>   * Dibs devices can optionally notify dibs clients about events that happened
> @@ -432,6 +509,22 @@ static inline void *dibs_get_priv(struct dibs_dev *dev,
>  	return dev->priv[client->id];
>  }
>  
> +int dibs_ring_register(char *name, struct dibs_ring_buffer *rb,
> +		       struct dibs_client *client,
> +		       struct dibs_dev *dibs,
> +		       uuid_t rgid,
> +		       u32 size);

Does a ring have a state?
Is dibs_ring_ack only possible after dibs_ring_set_rdmb_tok?

> +int dibs_ring_unregister(struct dibs_ring_buffer *rb);
> +size_t dibs_ring_space(struct dibs_ring_buffer *rb);
> +size_t dibs_ring_space_to_end(struct dibs_ring_buffer *rb);
> +u32 dibs_ring_cnt(struct dibs_ring_buffer *rb);
> +u32 dibs_ring_cnt_to_end(struct dibs_ring_buffer *rb);

naming? Is cnt the best name?

> +void dibs_ring_set_rdmb_tok(struct dibs_ring_buffer *rb, u64 rdmb_tok);
> +int dibs_ring_send(struct dibs_ring_buffer *rb, void *msg, u16 size, bool notify);
> +int dibs_ring_send_padding(struct dibs_ring_buffer *rb, u16 size);
> +void *dibs_ring_recv(struct dibs_ring_buffer *rb);
> +int dibs_ring_ack(struct dibs_ring_buffer *rb, size_t size);
> +
>  /* ------- End of client-only functions ----------- */
>  
>  /* Functions to be called by dibs device drivers:
> @@ -461,4 +554,10 @@ int dibs_dev_add(struct dibs_dev *dibs);
>   */
>  void dibs_dev_del(struct dibs_dev *dibs);
>  
> +struct dibs_msg_hdr {
> +	u8 version;
> +	u8 type;
> +	u16 datalen;
> +} __packed;
> +
>  #endif	/* _DIBS_H */
> 


Link: https://www.kernel.org/doc/html/v6.6/process/4.Coding.html [1]


