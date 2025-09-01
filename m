Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28852E11D2;
	Mon,  1 Sep 2025 09:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756719643; cv=none; b=Fs3IPloI58YzHsEhU763mTwBTWr4ZbOs1Qnxbf/TmiwCErzS+7IlpjZVQMuJu0GN1mv2rGgFyZLs1M5YdOES1oGClo6UTiQAIRSkEoIzT3q/g3y+O+q/DlRCgOXDmeVAUlzLXMc1Uviqm0leo/gSvIOESck7vXXnntnJn6uWc8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756719643; c=relaxed/simple;
	bh=T2oMNhJf3OWYBmKqw0UcAFYi0BfJGzakQ6uIIoUIvKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FVJAsPCrnqP1SVHSaU7rv9wTyO0ZNOzlnRyYXmvlrsJyiVHaH/PmvTW0Th9O/DTt40m7mIZ3zAkVcL+SJXyWzvFiL8bFaLfAP5FCqrtByOtPDSm2U96L8jE3uLkjPf8tVIIDN6yJyCOxL7/6mpo4q2ucRP5ize0wmAuuB1f6LfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3E97E43294;
	Mon,  1 Sep 2025 09:40:35 +0000 (UTC)
Message-ID: <8bc8b5b9-30a5-4c2f-b7a2-8074f8321d56@ghiti.fr>
Date: Mon, 1 Sep 2025 11:40:34 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] kexec: Fix invalid field access
To: Baoquan He <bhe@redhat.com>
Cc: Breno Leitao <leitao@debian.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Coiby Xu <coxu@redhat.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, kernel-team@meta.com
References: <20250827-kbuf_all-v1-0-1df9882bb01a@debian.org>
 <f7d55c91-8877-41aa-8cf0-64af38a9a109@ghiti.fr>
 <aLVhCuzhRTRnDytw@MiWiFi-R3L-srv>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <aLVhCuzhRTRnDytw@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduledukedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpedthfelfeejgeehveegleejleelgfevhfekieffkeeujeetfedvvefhledvgeegieenucfkphepudejiedrudegjedrudeghedrgeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudejiedrudegjedrudeghedrgeegpdhhvghloheplgduledvrdduieekrddurdduheelngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopeduledprhgtphhtthhopegshhgvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehlvghithgrohesuggvsghirghnrdhorhhgpdhrtghpthhtoheptggrthgrlhhinhdrmhgrrhhinhgrshesrghrmhdrtghomhdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegtohiguhesrhgvughhrghtrdgtohhmpdhrtghpthhto
 hepphgruhhlrdifrghlmhhslhgvhiesshhifhhivhgvrdgtohhmpdhrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhm
X-GND-Sasl: alex@ghiti.fr

Hi Baoquan,

On 9/1/25 11:02, Baoquan He wrote:
> On 09/01/25 at 08:42am, Alexandre Ghiti wrote:
>> Hi Breno,
>>
>> On 8/27/25 12:42, Breno Leitao wrote:
> .....snip...
>> I see that the commit those patches fix is in 6.16 so we should add cc:
>> stable.
>>
>> And who should merge those patches? Should we do it on a per-arch basis?
> It's been in Andrew's akpm-mm/mm-hotfixes-unstable.


Great, thanks for letting me know.

Alex


>
