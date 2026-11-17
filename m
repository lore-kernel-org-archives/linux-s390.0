Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794924774;
	b=q4sxuX4Ta1mD5IU52gG/IhemNIHI5Cvs68St9beCb/k4MxzwSpuZAtFFd9Kxq+M7Ytdg
	 QF1KnyT7LH8xIUhTBCJNakMJLO70ruuTHKXQ5cBHLjlcdo7c9H0KngqHO2+vj+wD/+MLl
	 Ytx9ekMfCmU4j5LIKaY3rGd8v+PpUK5dD4Mj7IBDoqeUoDZvGD+wrXTgE4eS1q5jNmVj8
	 QfJTqz+voCi1AG5pHEk7hBx5/sbari1JI3J/pKuWSlblmLyVrlSytFP5P3sbnkTStNEi8
	 kIbZDXqDyXAMbfUU8r4OMbtOUWdpARCWaJtjKRwEgnAbudxdT9rlwxCMGRyhXCKzmHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924774;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gBn6f8z11j5gal623IUn6lEjYuB55FouosiQxq1CosE=;
	b=s1LTuzHfBO/jPZZW9I85zLdvOwdXhWJj/Ru9w+SvM2t/fhjQCMjXizy/BCBNOPWgS28u
	 NMAvzP8/N3p5pZvjv9Srq9FLOE5FX/cf/GUuFPYnHX9DTroLMtwGtm8oxNEweNHqQUwhE
	 dcTOdl7IhKAJr77ecoPty+YQuo7J/ADNh0FuHn+n8cXbh9f5biyJ74HqDPGmoH4/vvUlk
	 XFmIxfWNHKef9Pt20MJq38U4cR4TZb42yfxjKKy2DA/d0SMyhbKoNfnwkoSBs3Kk1L7XF
	 gjO0TM6jL2VY1k7TzKvO+xsR83w1TGxdfoIF6UmWBURKTqgSC7uEzNXnK8x/WcuKjoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C2N5iftx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B9D606B088
	for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 14:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C2N5iftx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271E51F000C5;
	Tue, 17 Nov 2026 14:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794924774;
	bh=gBn6f8z11j5gal623IUn6lEjYuB55FouosiQxq1CosE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C2N5iftx4gn7QRw0zcdNe9WdrMfJ3K8BRswMrnmlRSJ6xwsevFwWjlLQ/imst+FGf
	 IkUjo1QLHOAkZKBcW1zvYI6SnJWYV24ho79pRU9jpO7qYwfjib8882XgRoUgTd388w
	 KFTqgYy9tmmkTPnjhs8hrTWQDoOQpwzM+sz1A26eh78Op6YdH33WxPiqMWVoZXw7aZ
	 IqMKJl4midOx6Wh3HO5tlIJL3RKejib1WF6Ehlp1wbGlHexbmkd6EhGtpmggwyjoES
	 9fZ6Hevhtcxr/NH34Lu9SwyXurZtuuXTSIU8zonw32qCk2y38rXOI7qMYyPB89VI5W
	 eFqFVeHrj4OeA==
Message-ID: <sashiko-outbox-218939@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/14] s390/sclp_con: Replace get_zeroed_page() with
 kzalloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261117-s390-sclp-ready-v2-5-e518c99622c6@kernel.org>
References: <20261117-s390-sclp-ready-v2-0-e518c99622c6@kernel.org>
 <20261117-s390-sclp-ready-v2-5-e518c99622c6@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 14:12:53 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> sclp_console_init() allocates the SCCBs that are used as the output
> buffers of the SCLP line mode console.
>=20
> These buffers can be allocated with kmalloc() as there's nothing special
> about them to go directly to the page allocator.
>=20
> kmalloc() provides a better API that does not require ugly casts and
> kfree() does not need to know the size of the freed object.
>=20
> Performance difference between kmalloc() and __get_free_pages() is not
> measurable as both allocators take an object/page from a per-CPU list for
> fast path allocations.
>=20
> For the slow path the performance is anyway determined by the amount of
> reclaim involved rather than by what allocator is used.
>=20
> Replace use of get_zeroed_page() with kzalloc() and free_page() with
> kfree().
>=20
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@re=
dhat.com
> Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-s390-sclp-=
ready-v2-0-e518c99622c6@kernel.org?part=3D5

