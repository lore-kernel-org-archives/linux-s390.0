Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D483B192;
	Tue, 13 Aug 2024 08:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723536347; cv=none; b=V/tx7MZcBpLnOuUsJz/mpJbJJQ/gzUDr47s51z9xoOb8x7K0B3k2VaQaoUUIqJSPLnWmgnr3+0b0RQ6E5EjYJeOq6fdla56SkN4m+pK/COs7bXFFt4wdI9PA9VymA7oUY3lfwC8LkhmSC83bl7tkpcepv4Oliq0advcLc+tI1no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723536347; c=relaxed/simple;
	bh=DPBm5/lLo95+kAKbLQ+nW7Ms/g5CjTl5s9SLRVdRHOo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gK+oKa+/sLUbZBY9E04dpQj7VJxTvVTbyqUDZ4APZ+h4k7oLbnisuPQElLi/IxZAiWVivwQNCjhSZW6rUDhk6ghXYwuyanmL11VZeW+NX17Wsup3t2qUt/gP02oIEPVjscLteb9ZumdNouXzjVPy/Jzw5etxE31FANNSlAcL0js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Bxaal+v/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Bxaal+v/"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47D6eXa7016388;
	Tue, 13 Aug 2024 08:05:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	Ny447N8RfLzE698T7XidAqzqHvul87K8fgyYVWB8YZU=; b=Bxaal+v/OEb9unq6
	SEgaV/rNriLW5ae+W38GwO36Z0WA2H0ZY4Ti9U/25i0q0pNDlpfjvJxsBQ3+Or71
	X7QxOQWn7wuubyGnfc3NHGCT2DldZFa43J0zJHcb9aAtqa4IQgosLesLSEHQjpxU
	47pTyjjLX/tBRZfoiB3fIvhVYGqBgIuXIAvM2pW5YkE6xp0Y7WvEccgeP/f4yuMc
	HMxXR9cA9zvNL6LpmjPCmwXzVQodrykK7BLFPYFqSS4WAy+TDgulmrIxtKQHtU1Q
	vmsWFY37dKkmfqgPbG85b/m2BdpnXmzE+gV+VIkdeSXYbqrIdYsrY0RY35BVtpTB
	LZYkaw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40wyq8q5rx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 08:05:38 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47D85cZV000891;
	Tue, 13 Aug 2024 08:05:38 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40wyq8q5rs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 08:05:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47D7V3K6010095;
	Tue, 13 Aug 2024 08:05:36 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40xjx0jp8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 08:05:36 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47D85UEI48038302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 08:05:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 788D420063;
	Tue, 13 Aug 2024 08:05:30 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E93B2005A;
	Tue, 13 Aug 2024 08:05:30 +0000 (GMT)
Received: from [9.152.224.39] (unknown [9.152.224.39])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Aug 2024 08:05:30 +0000 (GMT)
Message-ID: <9102add11cb13e94d3d798290e7d08145e8a6af9.camel@linux.ibm.com>
Subject: Re: [PATCH net] net/smc: prevent NULL pointer dereference in
 txopt_get
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Jeongjun Park <aha310510@gmail.com>, wenjia@linux.ibm.com,
        jaka@linux.ibm.com
Cc: alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, dust.li@linux.alibaba.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Tue, 13 Aug 2024 10:05:26 +0200
In-Reply-To: <20240810172259.621270-1-aha310510@gmail.com>
References: <20240810172259.621270-1-aha310510@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40app2) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ue7cqszvvChouMwqnxFK3CQNo8XhocSf
X-Proofpoint-ORIG-GUID: E8gWE-qh1c-Of6XUzMYA4zqkRXXdPbSN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_12,2024-08-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 clxscore=1011 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408130057

On Sun, 2024-08-11 at 02:22 +0900, Jeongjun Park wrote:
> Since smc_inet6_prot does not initialize ipv6_pinfo_offset,
> inet6_create() copies an incorrect address value, sk + 0 (offset), to
> inet_sk(sk)->pinet6.
>=20
> In addition, since inet_sk(sk)->pinet6 and smc_sk(sk)->clcsock
> practically point to the same address, when smc_create_clcsk() stores
> the newly created clcsock in smc_sk(sk)->clcsock, inet_sk(sk)->pinet6
> is corrupted into clcsock. This causes NULL pointer dereference and
> various other memory corruptions.
>=20
> To solve this, we need to add a smc6_sock structure for
> ipv6_pinfo_offset initialization and modify the smc_sock structure.

I can not argue substantially with that... There's very little IPv6
testing that I'm aware of. But do you really need to move that much
code around and change whitespace for you fix?

[--- snip ---]


> Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
> =C2=A0net/smc/smc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 19 ++++++++++--------=
-
> =C2=A0net/smc/smc_inet.c | 24 +++++++++++++++---------
> =C2=A02 files changed, 25 insertions(+), 18 deletions(-)
>=20
> diff --git a/net/smc/smc.h b/net/smc/smc.h
> index 34b781e463c4..f4d9338b5ed5 100644
> --- a/net/smc/smc.h
> +++ b/net/smc/smc.h
> @@ -284,15 +284,6 @@ struct smc_connection {
> =C2=A0
> =C2=A0struct smc_sock {				/* smc sock
> container */
> =C2=A0	struct sock		sk;
> -	struct socket		*clcsock;	/* internal tcp
> socket */
> -	void			(*clcsk_state_change)(struct sock
> *sk);
> -						/* original
> stat_change fct. */
> -	void			(*clcsk_data_ready)(struct sock
> *sk);
> -						/* original
> data_ready fct. */
> -	void			(*clcsk_write_space)(struct sock
> *sk);
> -						/* original
> write_space fct. */
> -	void			(*clcsk_error_report)(struct sock
> *sk);
> -						/* original
> error_report fct. */
> =C2=A0	struct smc_connection	conn;		/* smc connection */
> =C2=A0	struct smc_sock		*listen_smc;	/* listen
> parent */
> =C2=A0	struct work_struct	connect_work;	/* handle non-
> blocking connect*/
> @@ -325,6 +316,16 @@ struct smc_sock {				/*
> smc sock container */
> =C2=A0						/* protects clcsock
> of a listen
> =C2=A0						 * socket
> =C2=A0						 * */
> +	struct socket		*clcsock;	/* internal tcp
> socket */
> +	void			(*clcsk_state_change)(struct sock
> *sk);
> +						/* original
> stat_change fct. */
> +	void			(*clcsk_data_ready)(struct sock
> *sk);
> +						/* original
> data_ready fct. */
> +	void			(*clcsk_write_space)(struct sock
> *sk);
> +						/* original
> write_space fct. */
> +	void			(*clcsk_error_report)(struct sock
> *sk);
> +						/* original
> error_report fct. */
> +
> =C2=A0};
> =C2=A0
> =C2=A0#define smc_sk(ptr) container_of_const(ptr, struct smc_sock, sk)
> diff --git a/net/smc/smc_inet.c b/net/smc/smc_inet.c
> index bece346dd8e9..3c54faef6042 100644
> --- a/net/smc/smc_inet.c
> +++ b/net/smc/smc_inet.c
> @@ -60,16 +60,22 @@ static struct inet_protosw smc_inet_protosw =3D {
> =C2=A0};
> =C2=A0
> =C2=A0#if IS_ENABLED(CONFIG_IPV6)
> +struct smc6_sock {
> +	struct smc_sock smc;
> +	struct ipv6_pinfo np;
> +};
> +
> =C2=A0static struct proto smc_inet6_prot =3D {
> -	.name		=3D "INET6_SMC",
> -	.owner		=3D THIS_MODULE,
> -	.init		=3D smc_inet_init_sock,
> -	.hash		=3D smc_hash_sk,
> -	.unhash		=3D smc_unhash_sk,
> -	.release_cb	=3D smc_release_cb,
> -	.obj_size	=3D sizeof(struct smc_sock),
> -	.h.smc_hash	=3D &smc_v6_hashinfo,
> -	.slab_flags	=3D SLAB_TYPESAFE_BY_RCU,
> +	.name		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D "INET6_SMC",
> +	.owner		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D THIS_MODULE,
> +	.init		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D smc_inet_init_sock,
> +	.hash		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D smc_hash_sk,
> +	.unhash		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D smc_unhash_sk,
> +	.release_cb	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D smc_release_cb,
> +	.obj_size	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D sizeof(struct smc6_s=
ock),
> +	.h.smc_hash	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D &smc_v6_hashinfo,
> +	.slab_flags	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D SLAB_TYPESAFE_BY_R=
CU,
> +	.ipv6_pinfo_offset =3D offsetof(struct smc6_sock, np),

The line above together with the definition of struct smc6_sock seem to
be the only changes relevant to fixing the issue, IMHO.

> =C2=A0};
> =C2=A0
> =C2=A0static const struct proto_ops smc_inet6_stream_ops =3D {
> --
>=20

Thanks, Gerd
