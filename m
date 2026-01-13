Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B824368295
	for <linux-s390@vger.kernel.org>; Tue, 13 Jan 2026 06:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768287055; cv=none; b=E0K/aNK7rcCZQ6dY0MZW8ORA1RZNrLjjVKIJMW0cvviZ2mcctdCAgyufbZ8GV4jHO1kz5fHkVwWSe1jfYuEUhJvKTeMzt7GonouZvyadoxvic5Hj6hPmKpL/43XgGzpuMa3yM8o1UrsAKrc+WPK7RklR0DO9EbDXJYtjWuozGnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768287055; c=relaxed/simple;
	bh=aDB3sdHl8yEvBSscr99tVhZre5iBP2s4Ktcd0fugEGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XJBe+QeWoWhVu7mbcEERSwxNtHQ0SIqEyvtdIxy6rgWHVDM4AMZ5OIDk3iMx9zZS6yGMIlBretpY13kzn/5/ifNoxg6Ns71yG6k/JiHg7YJYJt0dGJmFQGEZ2UcZsxh3wWsfdKx+FDgbDBm6uishJGb09DtH48dXUUpfzcYqLP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDminwzO; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDminwzO"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-88a32bf0248so58459486d6.0
        for <linux-s390@vger.kernel.org>; Mon, 12 Jan 2026 22:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768287051; x=1768891851; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vX59/flKMUDb8zjb/CqTAfKlTuGyJwgf2lJ9POWv81Y=;
        b=aDminwzOmtGELvrpXwoJuF8Vised+qClS8KGMqtYTJiKEfsIaa5dWb3jmtAob22nDv
         twjz1EHrcgyDKfjRZ3Twgh4sHntR+paZs4j/WrWXcezBL5h9pZB+Y35Rpaoqj94bzJLH
         LzUJJDummWcO7+Fu9vmEXHAqMtN/RgAVNL3HVVVJ/KA9KgjbQbJw9SJjv2T+owOdJrSI
         gKtqBri2R3YLCNaWnzW1ZZwYkw5Kz5JavRwotg7jJ9otywgfhsKptyFtV2uULx+3+Hx6
         ffuyj5L+UjDyfUNovCLPg1y4mFHEIYGqp2qIrLLjXqPRk7VyPT1s4YT3HU1to52g4vnP
         AqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768287051; x=1768891851;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vX59/flKMUDb8zjb/CqTAfKlTuGyJwgf2lJ9POWv81Y=;
        b=B56ya/Gdkw1Q4i+hHt26PUFwHNA6iw0pJ5CRie4Ow0BFUO/Z8l1a1FONqz6wZNFN5m
         sRPErcByfYXQ2TslIOh93TfU7IikvFTiijHOvmcLr91GSpD3HQtX5tJEDURpjdXjg6Ox
         n3eU+0rHzLi294+h8z86oD/TPbGt7PX/WoRMWP9+xnlfVrBAqR6MYyMhgXi1uDwIz0dy
         EZp+6ZD20fHTGU25jfSa3YoCjdhBOlvF9CMrVSgsoXWEvz1Euu2199mvA/Y8bY2RCLxw
         LzOu1XKsM8SszMYAIQd32vA+QuHo82H/rEpLVjW5RnxSOUwyvr2UlpmlOnfP3HJyY0CW
         N55w==
X-Forwarded-Encrypted: i=1; AJvYcCWZ63mhyZ0shm0vgjL19kcxygqGwtWay/klXMfUKY3AsZQAhpE47gaKHT8/iox6q+pk3b1Lisfe5sIB@vger.kernel.org
X-Gm-Message-State: AOJu0YwsfYNGB0XricOtUl6tmMfaH0pGgbZszCQYrzpsy7ux5ewG/39A
	CUommb6HAxvjmxOh8fEZI/mPYxMoQed2h5/355PD3/N+Nyfbj/NqiFpi
X-Gm-Gg: AY/fxX6oObwRUNnIE20ZquGBObvaNbUVdvAsPkKoE6JuY9VFl1F0e6TlR8lHoBXCmgX
	ib6m5mIrmNsKc1dzfm08ALMu/+5oOWtV6L+ViTY26SzAxLVbjQ4g+faekLs3ykT3gXROX9spQbR
	v41JRhFWgiiKcAYYIRbUv4B18de1GpnTLZZb8einXgVCMUx62SEDvR1CNS+MK8KcRk6KXdz13Uk
	aLwKz8AXIuESqVSlLkxUUuuotGLbN/HSwrsDaUzZCSNZZX8Q1ETzoQd5wgHc3v5xZNU1FOzWsif
	ALDrudS8tqbqd+G9/tQb3JuCoqMAzIh7D5JoniYa9wyCzuEZfqxWZc3BdgM5/woNeqDvb9hx5uH
	xsh/xkdmaazAN8ReiTrOWp2wXsOTpWk+zCjHTV+ybhMbFRE7OXKEK1StVZq/7aZP+eAzXobnmlS
	E1bj6ZiMqevuJh+MO+b34Ac2LdLPeBq2SlauTHqNy98XGtjPBb8cc9qVR33g==
X-Google-Smtp-Source: AGHT+IFA85MjM1cnTGL5nks8UTBaUTRvSeGOw/MqVWENdA/8we2okwkLgNeF33lCoaLlOIlw7RP7mg==
X-Received: by 2002:a05:6214:4291:b0:888:81f1:a05e with SMTP id 6a1803df08f44-890842d1be9mr273660036d6.60.1768287051243;
        Mon, 12 Jan 2026 22:50:51 -0800 (PST)
Received: from [172.20.10.9] (mobile-access-c1d2ca-216.dhcp.inet.fi. [193.210.202.216])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770cdfb0sm152433806d6.6.2026.01.12.22.50.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 22:50:50 -0800 (PST)
Message-ID: <86b974d7-cabd-4913-b5f2-5b62b520e023@gmail.com>
Date: Tue, 13 Jan 2026 08:50:33 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/29] arch, mm: consolidate hugetlb early reservation
To: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Cc: Alex Shi <alexs@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Andreas Larsson <andreas@gaisler.com>, Borislav Petkov <bp@alien8.de>,
 Brian Cain <bcain@kernel.org>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 "David S. Miller" <davem@davemloft.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>,
 Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Jonathan Corbet <corbet@lwn.net>, Klara Modin <klarasmodin@gmail.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Magnus Lindholm <linmag7@gmail.com>, Matt Turner <mattst88@gmail.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michal Hocko <mhocko@suse.com>, Michal Simek <monstr@monstr.eu>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Palmer Dabbelt <palmer@dabbelt.com>, Pratyush Yadav <pratyush@kernel.org>,
 Richard Weinberger <richard@nod.at>, Ritesh Harjani <ritesh.list@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>,
 Vineet Gupta <vgupta@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Will Deacon <will@kernel.org>, x86@kernel.org, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-mm@kvack.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
 sparclinux@vger.kernel.org
References: <20260111082105.290734-1-rppt@kernel.org>
 <20260112142323.495fc43e662e7d276b0fa371@linux-foundation.org>
Content-Language: en-US
From: Kalle Niemi <kaleposti@gmail.com>
In-Reply-To: <20260112142323.495fc43e662e7d276b0fa371@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/13/26 00:23, Andrew Morton wrote:
> On Sun, 11 Jan 2026 10:20:34 +0200 Mike Rapoport <rppt@kernel.org> wrote:
> 
>> v3 changes:
>> * fix empty_zero_page initialization on arm
>> * fix ZONE_DMA limit calculation on powerpc
>> * add Acks
> 
> updated, thanks.  I'll suppress the ensuing email flood.
> 
> Kalle, can you please retest sometime, see if the BeagleBone Black boot
> failure was fixed?
> 
> Seems we haven't heard back from rmk regarding
> https://lkml.kernel.org/r/aVrUDeSkqqY9ZCtS@shell.armlinux.org.uk.

Hello!

I will test this v3 patch ASAP and reply results here.
Collective sorry for the delay; I have been busy!

BR
Kalle
