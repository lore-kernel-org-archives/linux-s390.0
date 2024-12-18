Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E64135949;
	Wed, 18 Dec 2024 21:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734558291; cv=none; b=JvjL2cLHyL2IjLFDOsFVWj9Mgam+go0aQmqdX2XSyu93oUMtGe/wtlatFwdEvsMpdwXX5vnVmlKNo3diNxeTzzEOqONCqHktYxLsaEYFoL7YKPBcZSXCRVLH+YmPlqrl4v1FFyH/wew97gzll8zVniGbFBo2fDQ65Hc7QJ+NcbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734558291; c=relaxed/simple;
	bh=edYBZ11YYqwZSp46/krx8ylEh93INu4/gD9nmkbYM7c=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=RYF2S61A4o+uCBONMFBYesMNBOh++ZAFgIPcvccqs6KBIuY25yRLYpN7Ih+UyscdsUVp+cqmfJ8HL58Xx+Hflbmm5SUTUE9R8S9EKZfZEcvVZyiWgEa4VI+ecWF+6OLWFLEc61jlkBPacWO3GlA3C8uSR6Eg7WXI4bEdL5rIxUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkgL6Byl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkgL6Byl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8940AC4CECD;
	Wed, 18 Dec 2024 21:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734558290;
	bh=edYBZ11YYqwZSp46/krx8ylEh93INu4/gD9nmkbYM7c=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=HkgL6BylkA2oCiTYEUxu6ip6gvJbDnAA9ohgrXER5+c7S1Y1fH8+tnFLcacxNgvUH
	 k+7Tenl6R0iAugypn+93OhXyCBbytyR+kKTVSs7akn1rN6Thp821D/ldVjLt12MDEf
	 lq6B45XkXfOf2lFitv2+QThkpiMUMQpup04WD6hGy+7BsY4NPwSLTz1rpG2XjTfajO
	 QmlEmmQ0VEPsRCDoMedzBJEq6Y4grdPTT0GdWW1P2emtLlfOsKjREkIH5dUraT01PV
	 ojRCVIj6tkg6HIB1tJUYGjePXJhZt6r5lTAi262ap8FkjJCzlrWRkzR3ouF/5bUREB
	 +Alpj5beJhjvw==
Date: Wed, 18 Dec 2024 13:44:47 -0800
From: Kees Cook <kees@kernel.org>
To: Alexandra Winter <wintera@linux.ibm.com>, Jakub Kicinski <kuba@kernel.org>
CC: linux-kernel@vger.kernel.org,
 ", linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 ", netdev" <netdev@vger.kernel.org>
Subject: Re: [PATCH] net: Convert proto_ops::getname to sockaddr_storage
User-Agent: K-9 Mail for Android
In-Reply-To: <aa6c671d-f4f4-446d-b024-923555c3f041@linux.ibm.com>
References: <20241217023417.work.145-kees@kernel.org> <aa6c671d-f4f4-446d-b024-923555c3f041@linux.ibm.com>
Message-ID: <C822C723-2141-4380-87FF-CA1D87FF8DBF@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On December 18, 2024 4:26:37 AM PST, Alexandra Winter <wintera@linux=2Eibm=
=2Ecom> wrote:
>
>I had to shorten the CC-List to get this message through our mailserver, =
sorry about that=2E
>
>On 17=2E12=2E24 03:34, Kees Cook wrote:
>> diff --git a/net/iucv/af_iucv=2Ec b/net/iucv/af_iucv=2Ec
>> index 7929df08d4e0=2E=2E2612382e1a48 100644
>> --- a/net/iucv/af_iucv=2Ec
>> +++ b/net/iucv/af_iucv=2Ec
>> @@ -848,14 +848,14 @@ static int iucv_sock_accept(struct socket *sock, =
struct socket *newsock,
>>  	return err;
>>  }
>> =20
>> -static int iucv_sock_getname(struct socket *sock, struct sockaddr *add=
r,
>> -			     int peer)
>> +static int iucv_sock_getname(struct socket *sock,
>> +			     struct sockaddr_storage *addr, int peer)
>>  {
>>  	DECLARE_SOCKADDR(struct sockaddr_iucv *, siucv, addr);
>>  	struct sock *sk =3D sock->sk;
>>  	struct iucv_sock *iucv =3D iucv_sk(sk);
>> =20
>> -	addr->sa_family =3D AF_IUCV;
>> +	siucv->sa_family =3D AF_IUCV;
>
>
>This does not compile, it needs to be:
>siucv->siucv_family =3D AF_IUCV;

Thanks! I saw 0-day reported the same=2E I've fixed this for the next revi=
sion=2E Do you happen to know why this doesn't get built during an x86 allm=
odconfig build?

-Kees

>
>> =20
>>  	if (peer) {
>>  		memcpy(siucv->siucv_user_id, iucv->dst_user_id, 8);
>
>
>With this change feel free to add my=20
>Acked-by: Alexandra Winter <wintera@linux=2Eibm=2Ecom>

--=20
Kees Cook
