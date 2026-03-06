Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22243988FA;
	Fri,  6 Mar 2026 13:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772803601; cv=none; b=FS2v6kMHWpWcjZmwREC73xzJkJUSjKCcuZaEfdwVIwTYWeqUyW644mGecrwsjXqWErwGvz6I5V2iJxW/Dv4LaahFTpIGbmBFe1gQiVolc3HaeKo3ah3TmnAhT+K6Mc7KSIxfT2rGbIoHbvBnAqZJyPfFFT/rP+0pbv4KXonFoOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772803601; c=relaxed/simple;
	bh=sR/kIGYNND8K9nQw+FjdFBOKIkK/ANUJzx5w8waG85s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QJWzMndx7+g9k/2zrKQmhtDdDbyjmRmznI8jVMQBmf0Sf8GbEzxhd8+/p2pZ4SvKi5ciFbcEww34KqivsvNOkW6uySOoACAodfbxWBPdRRy6lfv1F6Uy46vZEb2DzBPtBTh20iRxSKp50ruDrNFYGL7tLib9NXKUZPMnaNwrnGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVqpZu8S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVqpZu8S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F89C4CEF7;
	Fri,  6 Mar 2026 13:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772803601;
	bh=sR/kIGYNND8K9nQw+FjdFBOKIkK/ANUJzx5w8waG85s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qVqpZu8S/0TQR7CEKgDfDM8hrU1N4lLByrpecHCFJ9rd9kU2UuFJCwUl8CKVXZxsb
	 Fl/m8BIcs6TvfadSYBelOUxIOjBsO9TSySEvhI9Bw9VxhmMwHNHpBKsr/nf0NpApIE
	 Lzno5NcUDSeRl4qBWWD+UQn3vFc599K7kr7pM+HLyerwq89vH8/qIsW7EMzkXbchZp
	 wXnQcDRO0cNpto62BhoHJjxLyqNV9ovxlNkjrLgMhlD3d9ysgPfbkt2NWUo0i20Ajz
	 n1KwwMzAD0NVYw/WOdaDwVApZdC/YrZqyeFYf92rdOTiyvFay3e02NZvcq4kWQXpTb
	 wTPnLmsZLMXlA==
Message-ID: <e404a5a0-a46b-450f-bbf3-7bd8ea494bc2@kernel.org>
Date: Fri, 6 Mar 2026 14:26:33 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] vDSO: Use 32-bit CHECKFLAGS for compat vDSO
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 David Laight <david.laight.linux@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Sun Jian <sun.jian.kdev@gmail.com>, kernel test robot <lkp@intel.com>,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <20260302-vdso-compat-checkflags-v2-0-78e55baa58ba@linutronix.de>
 <96cdd223-5139-4535-b82d-831dac472cc3@kernel.org>
 <20260306115350-ef265661-6d6b-4043-9bd0-8e6b437d0d67@linutronix.de>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260306115350-ef265661-6d6b-4043-9bd0-8e6b437d0d67@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 06/03/2026 à 14:08, Thomas Weißschuh a écrit :
> On Fri, Mar 06, 2026 at 11:43:24AM +0100, Christophe Leroy (CS GROUP) wrote:
>>
>>
>> Le 02/03/2026 à 08:58, Thomas Weißschuh a écrit :
>>> When building the compat vDSO the CHECKFLAGS from the 64-bit kernel
>>> are used. These are combined with the 32-bit CFLAGS. This confuses
>>> sparse, producing false-positive warnings or potentially missing
>>> real issues.
>>>
>>> Manually override the CHECKFLAGS for the compat vDSO with the correct
>>> 32-bit configuration.
>>>
>>> Not all architectures are supported, as many do not use sparse for their
>>> (compat) vDSO. These can be enabled later.
>>>
>>> Also add some checks to bitsperlong.h to detect such issues earlier.
>>>
>>> Based on tip/timers/vdso.
>>>
>>> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
>>> ---
>>> Changes in v2:
>>> - Simplify __BITS_PER_LONG consistency checks
>>> - Fix an inconsistency in the powerpc audit code
>>
>> The powerpc audit code should be replaced by generic
>> AUDIT_ARCH_COMPAT_GENERIC, as there is no difference between them
>> apparently.
> 
> Agreed.
> 
>> A tentative was made in the past but was declined by audit maintainers
>> because we were not able to test it allthought the failure was the same
>> before and after the patch, see
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Flinuxppc%2Fissues%2Fissues%2F412&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Cca6c85b42bd44c6a80c608de7b81819d%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639083993321723266%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=VxTy22klpH9H8Altgcthr%2F%2ByUIL6q%2FbBkDV7FQS%2BljI%3D&reserved=0
> 
> On v7.0-rc1 the test failure of filter_exclude/test is gone.
> It also keeps working when applying your patch. Some other tests are
> broken, but it looks that is due to missing dependencies on Debian.
> So maybe it is time to resubmit your patch.
> 
> In any case, I don't really want to entangle my series with the switch
> to AUDIT_ARCH_COMPAT_GENERIC. My proposed cleanup does not make the code
> worse and if both patches are applied the conflict will be trivial to
> resolve.

I didn't mean to interfere with your patch, it is just that your patch 
reminded me that tentative.

Thanks for testing, I will consider re-posting my patch based on your test.

Christophe
