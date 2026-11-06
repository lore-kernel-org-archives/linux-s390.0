Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793980038;
	b=a1yyQbnYFyRJIcwwLb4G7Hgeecte3ZBB9061EaVfXz1Z2cdyRbBIju76enA9HUrmjbkz
	 ije1/RgE8SEMae2sxC14E62DdQNI+UY1sw0SyFHkploaRIhW0it7EeeV+NfOaWDczfeXd
	 QC9Lx1RPKXkcZZzrvIshTlLzTIeYlBtPhq3yMteg1mcZkT/nHB6164dMfvcB/vEMyYx35
	 mO5vN6FEiNzmKTYjVyVUCdW10b+NQOPlVZvK2u8AUdKTuj7q7rpIg9c+M9yyExNiFJJjp
	 kkJXJDUN9vtTWL2W/uB4v3ftYX2V+lWOs4yuHd7v0EZMnMLjXMlmFHbfa8BkR1MVO9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793980038;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pOU2XeGE15Q8XYzBIQfOZEIc206vYoHPXlHiiF3z9uM=;
	b=gPayg1du1u2cAzzzzk/0XLrRA3JIczpHdJInftguxGFq41S+d4ylKrvoeshoPToLkN2i
	 yaD0YT79G7IOX5+joB7BIiXgrJuqSMx4OB9D/IhgyM/HUI6n4PBaGkpmZgVyXdvYMlzhf
	 zP6ekzIuZpgRXeJplMgXWqg7n/3wiRrFLSgCQ125cpRtC66VrflXLekawB/u2pcAIeHun
	 ruEy8iwaV03rmx0yJ8QzdkS1phC+cMzasuzrsf2DHc8lIeAamRDS8FJlwSGB1O6iUGLux
	 wdxMbaRr4vfZSeYaXbx7qSe2mNF8+MgstX9t3FpWfM4NETUmD2MSDe0D1IiKTUSt6jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="m/Ca6F8y";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7ADC606A330
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 15:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m/Ca6F8y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C371F0089F;
	Fri,  6 Nov 2026 15:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793980037;
	bh=pOU2XeGE15Q8XYzBIQfOZEIc206vYoHPXlHiiF3z9uM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m/Ca6F8yhsQqJINJ1ZvHkn9BGTkSpDN8bqOFIu4W/s5JbhELpTJbVlqDyrDzU2rR9
	 GcpzyzXSV9bhS5s0mz4ESnywH3vhrkHlQG5RNrIl1dUsi1ABvAmB4n8hnVFNXod8Dh
	 9PeRInlmg6ffw3I04BETmmsf2YctmB7QMarEEYivgvuJcIBUTN3AK+u3j80JGVP5XE
	 IVYMyUDDPs21V5Tn5CIMWC0JltuIpJXGAa/hiWT+IqPozeTf8T5cuNupKyL1d8qoRp
	 60gOUm5BZ/fGgkq+v5vxuXpzRUUoKYO3OycJI2CASUrf6VPNInByXrMjiVzbYRVxvi
	 lV0hfJ9PoI67Q==
Message-ID: <sashiko-outbox-201729@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 03/14] s390/vfio-ap: Functions to initialize/release
 vfio device migration data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106152259.1360651-4-akrowiak@linux.ibm.com>
References: <20261106152259.1360651-1-akrowiak@linux.ibm.com>
 <20261106152259.1360651-4-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 15:47:16 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Provides the functions that initialize and release the data structures
> used during live guest migration:
>=20
> * vfio_ap_init_migration_data
>=20
>   Allocates and initializes the object used to maintain the state of the
>   VFIO migration. It is called when the VFIO device is opened and does
>   nothing if the object was allocated by a previous open.
>=20
> * vfio_ap_release_migration_data
>=20
>   Frees the memory of the object used to maintain the VFIO migration
>   state. It is called only from the VFIO device release callback. It is
>   not called when the VFIO device is closed because a migration file
>   descriptor, which references the object, can outlive the VFIO device
> [ ... ]
>   pointer in, the vfio_ap_migration_file used during the RESUMING phase
>   of migration. It also clears the flag indicating a complete AP
>   configuration was received.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106152259.1360=
651-1-akrowiak@linux.ibm.com?part=3D3

