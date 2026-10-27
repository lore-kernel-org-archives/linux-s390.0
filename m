Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793140995;
	b=eOhDvMOq2zVEwxdhu3Y2Mt/mRimZI0OTzE/qismsFRcQPicqEnJLX5I9/Nr+rz8pZ6uB
	 txCp5YU4zXcI1vF+7C8BW6HlENIQnWzNoaEqX/a6XJIp6ifySrz2TtRhn9nM0Ktv052Oa
	 BnVic98mrB4PTWOubZkcxU7jJOa/F9O108tRyEWhSGMSxtM6BSJL8+M0wRvKXZ8Wa7FeS
	 fhnemwzstMJ+Y9bsd3EhhxrKcFnal+d0mT1DCaus3pkqwILWlcL+KvkCp4dyOhPzRsOiH
	 pKYHlD5rE4gL4+Cwtn4OvDypsxV6PwWsh+OWrQt0TBpc0xIi4QF9bOsBdRxAySZ3ZTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140995;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=q3KbsETr+or17LqG8a5e8dtKY1wk41Abe8HIFI+j9ag=;
	b=26gBvqJwC5cBtKEvBn0wPyJAO6wIf4jabVEOYSK84+KeFgwuebTS10Cox+xXffaW7sTs
	 skcZ7NPZRLJu2scIooXrryR6zQnZTS4j+mc25Hsp9ydydvVA6zl0xWo0sxemWrCCBEweR
	 funz3wDCVJ1pJtdiSzg3T60DZIxegLhnKUxS00tEOAsHs5+rLZu/6/MBjHD8yxM0pZb8J
	 9H8eFanlyrsgKb9lv7qXDQGod48oxdyjuR773L2hTSWSHXagKO6mLqaOiaNZGKDycXxjV
	 GBdxBBopG+Q4TbSpPvy9mrZwIbyOCOLC+/z8GwILTmohqju29/1JZa8ho3qVxz1kLZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hDqVWOvP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E1A606A31A
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 22:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hDqVWOvP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D519B1F01825;
	Tue, 27 Oct 2026 22:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793140995;
	bh=q3KbsETr+or17LqG8a5e8dtKY1wk41Abe8HIFI+j9ag=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hDqVWOvPKO5e7W7p9CjONQjY6h4tOlj6Bb9yHLA7vWzK3/PflVHoSBsJwYFfyQHo4
	 uWLckT4tq7lAx9un3ZlkN1v5xbVBsrkmpVurlasZhZpBrLo8j7XUeAPXN7rXx7Zuky
	 1ffQkpqEnbooTdpl3NTbLeK53otCkCbM3uL1cMXVQnZNVu6jw+vQexUeUXX0jmesGY
	 l2wAb2wRBu4R1RZHd5+YqmFwEQKWm6MG7p3TrWzcsTmIK1sOBgSiYf8wwrxz5PFyV/
	 VLuGXR3wcEjpPTTyi6uaNUcuPmx6dPELDwaZj4O0x2h6KFKkHprQcLaxEvwTc7ZuzO
	 z/J9gK0rQm8tw==
Message-ID: <sashiko-outbox-187173@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/9] cpufreq: governor: Initialize kobj_type release
 callback statically
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261027223847.652884-5-irogers@google.com>
References: <20261027223847.652884-1-irogers@google.com>
 <20261027223847.652884-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 22:43:14 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Export cpufreq_dbs_data_release() and set .kobj_type.release statically
> in the ondemand and conservative governors so their gov_attr_set
> kobjects have a valid release callback statically initialized, matching
> cpufreq_governor_dbs. Remove the redundant runtime assignment in
> cpufreq_dbs_governor_init().
>=20
> This prepares for annotating struct kobj_type::release with
> __must_init.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027223847.6528=
84-1-irogers@google.com?part=3D4

