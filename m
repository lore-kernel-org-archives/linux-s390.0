Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794603588;
	b=st9fgqs8g0ZX3gOhEyGx+TpC1hTgrnEYu3ZHPP9BQrA62ygGAW0AEkDWTSYno8osae+3
	 hLsOqNQQqKfXwciiAKVoJM/77JsmyCdT0doqsU28/IsHZShVg/2SCRN3zDr+kKwiUvas9
	 GqzOihcuH5gaRnE6K6Shf8QhcBscTx0sq5yWkqJqHt0H5bZWkab2BcdlLodpOTC+WUPyQ
	 uR05OCR25YlH1C18wDiGqQ3mkoUvkw0uFRYUboqgb/BVaNNg/6upEPDMSREH4X+EnSP40
	 qZhkRRjNtzHJxqiKZqLxU3PX5r43bhWZ3s8ls2WgCfPmJAHSDnEnl+j0yy52MrdQBDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794603588;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=gVxBLZX6lQzckB6AIbX2pQJru5dIfjw9YVDcZIdu890=;
	b=PbmFC0F1Y4QcRP4zFtp9deNZ+q6Uj7DGauz2wcp2hTpy72kR45UtcoUd7CaiGqkhmyJ6
	 cOubVwwISXG6lx380SmxvVsUXutJBOjlQW4JDgWD4YhvorSCTozSBX9K2roamqpGjl8V7
	 t+nDJWbBVBBcJOIK+Czo9F+jahVTfHl+e4PkyzUr6quVozeaXEAilt0iXo2dDD6x7Ywd/
	 Yuryb+elFSwBAofsNYTSo0MmwbMo8YFWwY08/Xf01oVTz+I23u5w+caDBL4FDiWeDkSqW
	 /rBBKRQVgJhFWco3ROg0PtK1x5Y04ONrTTcNpk2HDP1sQwl5bZLHigPcNmPV/uLx1CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="EfCt/jkE";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88D0606A895;
	Fri, 13 Nov 2026 20:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EfCt/jkE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F951F000C5;
	Fri, 13 Nov 2026 20:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794603588;
	bh=gVxBLZX6lQzckB6AIbX2pQJru5dIfjw9YVDcZIdu890=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EfCt/jkEInFzOANdOTJJt6IXsNytJX76wHVHRjNrF88Xjw3qp6MqJvxVq0PDoGQid
	 HqvdYMbEdN2obhqGDYDFJojlub4fnNPZJ9U6j8sGvuMtgJAcJYJFKs2Qz44cw4RLcI
	 o3RbslRdMuWZOtId3qgp6zZyQESV4Se91+5ZGEBshlKorXhB8sG6T+/l44w7rZME58
	 0e/97s29kipqBUVU+icJTEC19aN6eGp44UBq0S/kxYuXWjwxzXQZldSIhlPYj5G+y0
	 oV0hi0WdohvhJftm39HJNM/uH2AUVFNv4JQ/P5qHhRkj/03UVRKTtC7bn/zMsPkp2q
	 MRBAcCm7m0NGg==
Date: Fri, 13 Nov 2026 20:59:41 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Carlos =?utf-8?B?TMOzcGV6?= <clopez@suse.de>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-riscv@lists.infradead.org, seanjc@google.com, 
	pbonzini@redhat.com, akpm@linux-foundation.org, david@kernel.org, peterx@redhat.com, 
	imbrenda@linux.ibm.com, borntraeger@linux.ibm.com, frankja@linux.ibm.com, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Subject: Re: [PATCH v3 0/9] KVM: don't zap secondary MMU on permission upgrade
Message-ID: <avd4MOhiTCw0I_e1@gremlin>
References: <20261112142039.907090-2-clopez@suse.de>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112142039.907090-2-clopez@suse.de>

Sorry but as I said to David I really question what you're doing with this
series on the mm side, and I wonder whether we should even consider it for
this cycle, frankly, given [0].

And, myself being the fool who is engaged in the Sisyphean task of
converting VMA flags everywhere, you can imagine my delight when I saw that
you (seemingly quite knowingly!) chose to abuse that API, writing code that
I'll personally have to rewrite later.

Don't do that please :)

Please also do not keep respinning based on sashiko feedback. FIRST get a
clear understanding of what maintainers want.

Sashiko is a bug finder, not a reviewer.

And see [1]:

"Wait for a minimum of one week before resubmitting or pinging reviewers -
possibly longer during busy times like merge windows."

Please only respin once a week at the minimum.

--
Cheers, Lorenzo

[0]: https://lore.kernel.org/linux-mm/a2f584f6-e382-4876-aa6d-d5a34de6ee59@kernel.org/
[1]:https://docs.kernel.org/process/submitting-patches.html#don-t-get-discouraged-or-impatient
