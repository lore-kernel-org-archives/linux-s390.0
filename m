Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A05148305;
	Tue,  4 Jun 2024 16:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717517799; cv=none; b=unW5wUBbOj0Da0vyiM/mVbLoMV8Otp3S9X1dFoOKXPWqk08ZvSoQ6WOVys5iiBc8iH1WUSXThtT+NA6mSvn/MHa7PCvXX20mXYajAgs34u/EU+mrgIIU1rSp93+rCOSoabb3ZJ0B2spEaoWjKHvMOxEQJYv+Tij4Unxozbxzmm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717517799; c=relaxed/simple;
	bh=1e9RG+2Ze+kSjju4jnURgtLVyboPBj/hCLl0BkLzV0Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d+kv+ZxUdQ9Gv1PTL72an4DLedgrNgXLr7q+UTpH4VJr7QrSr4/0Ox58G+OHtP+RgekJgn5cVXwZuTb2X6aKivly8n0XgELGwmiSIm8rNCG92YCrP5lVdYxtZ2JJABgnfjSQUP4ehvQ+xl0Sr2mEgNooyWLKSvtT+CkgT/Ida3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eC1xsCLQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eC1xsCLQ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454Fq8A4023070;
	Tue, 4 Jun 2024 16:16:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=ZtCksyZ8jmBRtowIXUVm+kXmHPyAtzAyf+9pX8s/W/I=;
 b=eC1xsCLQFLTbJDYWlntSfEYu9x7FLtoitYrbbuSuCvsAm+418OyjUQ9Yop/qdHld5cMc
 HCE0k6BL0J1sPLyTBKUDvsLv2dkNF/tu9ruOrtmL/hfYpoRJuim2tNuNUW7rsqBZJkFl
 03HqZ94O9FR8mFO68zP191GbzYIvuFj8kBpxrxMrhgS5rerhMPGn+Xm9D7CeeZEaAzMH
 PftX5NXRaB6Jimm5NA7qmzxpVS/nKLeOTcKPbDHA6jq2xN+PWsMiYlYnVVzfXiN1FGCF
 STOL+DwRiY9+C+Dq2jICQaRWvcRCi0Zkquw1vO4nvW3lAkIqfC/V+2IVUH9auWVuDIun Aw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yj5xm82dx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 16:16:34 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 454GCs5c026187;
	Tue, 4 Jun 2024 16:16:33 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yj5xm82dr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 16:16:33 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 454DvW5w022794;
	Tue, 4 Jun 2024 16:16:32 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ygg6m6q0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 16:16:32 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 454GGQ8X49086932
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Jun 2024 16:16:28 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CC6920049;
	Tue,  4 Jun 2024 16:16:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3619420040;
	Tue,  4 Jun 2024 16:16:26 +0000 (GMT)
Received: from [9.152.224.39] (unknown [9.152.224.39])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Jun 2024 16:16:26 +0000 (GMT)
Message-ID: <cc606c7b6fb53d00d80122b987c94bd7cb385af0.camel@linux.ibm.com>
Subject: Re: [PATCH net] net/smc: avoid overwriting when adjusting sock
 bufsizes
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Wen Gu <guwen@linux.alibaba.com>, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc: alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Tue, 04 Jun 2024 18:16:21 +0200
In-Reply-To: <20240531085417.43104-1-guwen@linux.alibaba.com>
References: <20240531085417.43104-1-guwen@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40app1) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 30IDO0IliIBx3wuhW8Ez_EelcRsmh699
X-Proofpoint-GUID: qdyy8YkF-p-cxQRE0l5eaAmfYc0BlW3z
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2405010000 definitions=main-2406040130

Hi Wen Gu,

sorry for the late reply, I'm just catching up after a bit of a
vacation.

On Fri, 2024-05-31 at 16:54 +0800, Wen Gu wrote:
> When copying smc settings to clcsock, avoid setting clcsock's
> sk_sndbuf to sysctl_tcp_wmem[1], since this may overwrite the value
> set by tcp_sndbuf_expand() in TCP connection establishment.
>=20
> And the other setting sk_{snd|rcv}buf to sysctl value in
> smc_adjust_sock_bufsizes() can also be omitted since the
> initialization of smc sock and clcsock has set sk_{snd|rcv}buf to
> smc.sysctl_{w|r}mem or ipv4_sysctl_tcp_{w|r}mem[1].
>=20
> Fixes: 30c3c4a4497c ("net/smc: Use correct buffer sizes when
> switching between TCP and SMC")
> Link:
> https://lore.kernel.org/r/5eaf3858-e7fd-4db8-83e8-3d7a3e0e9ae2@linux.alib=
aba.com
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---
> FYI,
> The detailed motivation and testing can be found in the link above.
> ---
> =C2=A0net/smc/af_smc.c | 22 ++--------------------
> =C2=A01 file changed, 2 insertions(+), 20 deletions(-)
>=20
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 9389f0cfa374..a35281153067 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -459,29 +459,11 @@ static int smc_bind(struct socket *sock, struct
> sockaddr *uaddr,
> =C2=A0static void smc_adjust_sock_bufsizes(struct sock *nsk, struct sock
> *osk,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long mask)
> =C2=A0{
> -	struct net *nnet =3D sock_net(nsk);
> -
> =C2=A0	nsk->sk_userlocks =3D osk->sk_userlocks;
> -	if (osk->sk_userlocks & SOCK_SNDBUF_LOCK) {
> +	if (osk->sk_userlocks & SOCK_SNDBUF_LOCK)
> =C2=A0		nsk->sk_sndbuf =3D osk->sk_sndbuf;
> -	} else {
> -		if (mask =3D=3D SK_FLAGS_SMC_TO_CLC)
> -			WRITE_ONCE(nsk->sk_sndbuf,
> -				=C2=A0=C2=A0 READ_ONCE(nnet-
> >ipv4.sysctl_tcp_wmem[1]));
> -		else
> -			WRITE_ONCE(nsk->sk_sndbuf,
> -				=C2=A0=C2=A0 2 * READ_ONCE(nnet-
> >smc.sysctl_wmem));
> -	}
> -	if (osk->sk_userlocks & SOCK_RCVBUF_LOCK) {
> +	if (osk->sk_userlocks & SOCK_RCVBUF_LOCK)
> =C2=A0		nsk->sk_rcvbuf =3D osk->sk_rcvbuf;
> -	} else {
> -		if (mask =3D=3D SK_FLAGS_SMC_TO_CLC)
> -			WRITE_ONCE(nsk->sk_rcvbuf,
> -				=C2=A0=C2=A0 READ_ONCE(nnet-
> >ipv4.sysctl_tcp_rmem[1]));
> -		else
> -			WRITE_ONCE(nsk->sk_rcvbuf,
> -				=C2=A0=C2=A0 2 * READ_ONCE(nnet-
> >smc.sysctl_rmem));
> -	}
> =C2=A0}
> =C2=A0
> =C2=A0static void smc_copy_sock_settings(struct sock *nsk, struct sock
> *osk,

As Wenjia already said, we've discussed this a bit.
As I remember, I've added the sections to copy over the sysctl values=20
as a "safety measure" when moving between smc/clc sockets - but had the
wrong assumption in mind that e.g. in a fall-back a new TCP handshake
would be done. Apparently, we didn't test the buffer size behavior in
these scenarios enough to notice the "weird" behavior.

So we reviewed your initial report of the oddity per your message in
the link above, too.

We fully agree that if no connection at the SMC level could be
established, you should expect the socket buffersizes be used that had
been established for the TCP connection - regardless if the fallback is
due to the server or the client.

So feel free to add my
Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>, too.

Thanks,
Gerd
