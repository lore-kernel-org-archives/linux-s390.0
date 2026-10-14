Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3719259C82;
	Wed, 14 Oct 2026 11:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791978702; cv=none; b=jlMxZn2hkExQkXsZPWihFx8zQO8icEZs9+ZHh/gXEBtOtxWFK7eDNPHnP1XTE2QRQCwLIumb+4TNf1iY0MEszwzp4Q499Wd0F5CO+V9VNEq1h45T1dW1C5mXcfq+PJDIxViIHpFxUy8c3Kx6iRlJUhV3rbH0lFZhmDq5vuawQh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791978702; c=relaxed/simple;
	bh=332V8JwG+JWD45jKpNGkD4yH8RmdKzKFos55fW7jgCY=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jTob6qNJoJo4zj/KN4b4glRFqZJGkQaJlAXqPcGs69F4Ikeg14Ndh64NG23UtKoO1r1F54gaMR+IapJWJyFG5MG4JrSOX/H5Ui2lcMZjvPc4rnX367svM+9sFildgiOyDjE+T8p2KIs/AENkEu2b2jFcOHspfZqKr3+gIne+BEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=NRQ2Wyi3; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="NRQ2Wyi3"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=xVlOyYaOJuVGaDfnk3Cn8S4up3VyrQrAPSaBBvMWJK4=;
	b=NRQ2Wyi38AJGPQbJ80NuIBLnWk6SwO8PaLyJaV87efjwedpEJ9wjoxegROCOJ8+sMuMWLGkWu
	Rm4/b05wv/F91TtAb5MycVTFxtVEUQvci6R9jyHnyeOMNTzXjiNJSTCZN3PILjcWfI1v2zeSqLV
	B62e3eM4uUujj0AqiqJDPNY=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4j4Tkr1HPxz12LD9;
	Wed, 14 Oct 2026 19:39:32 +0800 (CST)
Received: from whupemo200011.china.huawei.com (unknown [7.152.185.179])
	by mail.maildlp.com (Postfix) with ESMTPS id 24D014056E;
	Wed, 14 Oct 2026 19:51:26 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 whupemo200011.china.huawei.com (7.152.185.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 14 Oct 2026 19:51:21 +0800
Subject: Re: [PATCH 09/11] ubifs: sysfs: Use kset_create_and_add() for
 ubifs_kset
To: Ian Rogers <irogers@google.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Kees
 Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>
CC: Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
	<morbo@google.com>, Justin Stitt <justinstitt@google.com>, Jonathan Corbet
	<corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman
	<mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
	<chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, Yoshinori Sato
	<ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, John Paul Adrian
 Glaubitz <glaubitz@physik.fu-berlin.de>, Viresh Kumar
	<viresh.kumar@linaro.org>, David Teigland <teigland@redhat.com>, Alexander
 Aring <aahringo@redhat.com>, Juergen Gross <jgross@suse.com>, Stefano
 Stabellini <sstabellini@kernel.org>, Oleksandr Tyshchenko
	<oleksandr_tyshchenko@epam.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
	<svens@linux.ibm.com>, Richard Weinberger <richard@nod.at>, Felix Kuehling
	<Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
	<driver-core@lists.linux.dev>, <llvm@lists.linux.dev>,
	<linux-hardening@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-sh@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<gfs2@lists.linux.dev>, <xen-devel@lists.xenproject.org>,
	<linux-s390@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>
References: <20261013223946.1836757-1-irogers@google.com>
 <20261013223946.1836757-10-irogers@google.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <3f6e7a0d-ba41-89dd-012f-9ac24e12da9d@huawei.com>
Date: Wed, 14 Oct 2026 19:51:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261013223946.1836757-10-irogers@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 whupemo200011.china.huawei.com (7.152.185.179)

在 2026/10/14 6:39, Ian Rogers 写道:
> ubifs_kset was a static struct kset using a custom ubifs_ktype that
> had no default_groups and no .release callback. With
> CONFIG_DEBUG_KOBJECT_RELEASE=y, unloading the ubifs module while delayed
> kobject release is pending causes a use-after-free on the static kset.
> 
> Replace the static ubifs_kset and empty ubifs_ktype with a dynamically
> allocated kset via kset_create_and_add().
> 
> Fixes: 203a55f04f66 ("ubifs: Fix memory leak in ubifs_sysfs_init()")
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   fs/ubifs/sysfs.c | 24 +++++++-----------------
>   1 file changed, 7 insertions(+), 17 deletions(-)
> 

Tested-by: Zhihao Cheng <chengzhihao1@huawei.com>
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> diff --git a/fs/ubifs/sysfs.c b/fs/ubifs/sysfs.c
> index dbf967dcf26e..e20931e3a62f 100644
> --- a/fs/ubifs/sysfs.c
> +++ b/fs/ubifs/sysfs.c
> @@ -80,13 +80,7 @@ static const struct kobj_type ubifs_sb_ktype = {
>   	.release	= ubifs_sb_release,
>   };
>   
> -static const struct kobj_type ubifs_ktype = {
> -	.sysfs_ops	= &ubifs_attr_ops,
> -};
> -
> -static struct kset ubifs_kset = {
> -	.kobj	= {.ktype = &ubifs_ktype},
> -};
> +static struct kset *ubifs_kset;
>   
>   int ubifs_sysfs_register(struct ubifs_info *c)
>   {
> @@ -107,7 +101,7 @@ int ubifs_sysfs_register(struct ubifs_info *c)
>   		goto out_free;
>   	}
>   
> -	c->kobj.kset = &ubifs_kset;
> +	c->kobj.kset = ubifs_kset;
>   	init_completion(&c->kobj_unregister);
>   
>   	ret = kobject_init_and_add(&c->kobj, &ubifs_sb_ktype, NULL,
> @@ -139,18 +133,14 @@ void ubifs_sysfs_unregister(struct ubifs_info *c)
>   
>   int __init ubifs_sysfs_init(void)
>   {
> -	int ret;
> +	ubifs_kset = kset_create_and_add("ubifs", NULL, fs_kobj);
> +	if (!ubifs_kset)
> +		return -ENOMEM;
>   
> -	kobject_set_name(&ubifs_kset.kobj, "ubifs");
> -	ubifs_kset.kobj.parent = fs_kobj;
> -	ret = kset_register(&ubifs_kset);
> -	if (ret)
> -		kset_put(&ubifs_kset);
> -
> -	return ret;
> +	return 0;
>   }
>   
>   void ubifs_sysfs_exit(void)
>   {
> -	kset_unregister(&ubifs_kset);
> +	kset_unregister(ubifs_kset);
>   }
> 

