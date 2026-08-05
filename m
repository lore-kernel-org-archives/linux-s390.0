Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C8B361DDA;
	Wed,  5 Aug 2026 15:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785945450; cv=none; b=q0f8bvah+hTn1+TDdfkXQxqQKH/OWmgITxNo09Tc6uRktcj8r49XvIrm4IFMLkiEUZoE4D0/vlAmMk5N4HiJ5+8nkiF0AxbX9hW/+QqgYRKCkIs3g+LxCWw+VwAQjQsdty09oXj6Gj2Vx0/kD2jS9+ZwdSGUnQ6JJnUA7mdIZC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785945450; c=relaxed/simple;
	bh=GOuBNrIp9K9Rk/B7Lnh6vqWtjjXAlDsdSnZqHl0zc/A=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lcExhwtnUsmCxp0OZJHlHCKjyxW/9rcs2m4SdgLxKWrpHSh6DgjnMkc3coUBW/R3C/+rn4eeD7aa7ziT6eiNxeyGyjLSn7LrTD4R90dphiiahP9fY9zY6u/XLGECudFdV4L6yXOomAQq/bKdSDyjfLP2BUv/vYwQlpOEZ7LGV+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=f7noF4+C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mmbjj+cR; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="f7noF4+C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mmbjj+cR"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.phl.internal (Postfix) with ESMTP id EA7B8EC0105;
	Wed,  5 Aug 2026 11:57:25 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Wed, 05 Aug 2026 11:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785945445;
	 x=1786031845; bh=p4r12+UHkr+EMzZhSZv8ak/jx56YQfzXVFQO5KTlhKg=; b=
	f7noF4+C+VRJcm8lqrTHpsubYlKhVEEh/L1/G5h1jEAKqr06csbJd46YjK/AYZxM
	CJ6naTxt8art2w9WDhiuZFR6V+Wey9DD+qAfwwCf2KFTvfr8z3IyxZtWrzSNRNia
	+TEpcfQ6rYYraSh7MKr2k309mAiZ/rmgNsPjDWndic568VhHlnXzq5g743Tgpqre
	a2jclVlCDUWMBM4b+dnjH3WCjteWdieKUb85jVgd+EACUYn4thxwCa00ae+4klAo
	b7yQGlibfKm2XgQpqJNzdeo+t3owjHFtERHzUBRpBvK3IX6pwh/2YI3+FdUnGm0l
	J6Esj1ClfLnNSkmttNDLoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785945445; x=
	1786031845; bh=p4r12+UHkr+EMzZhSZv8ak/jx56YQfzXVFQO5KTlhKg=; b=m
	mbjj+cR+/65nzm4ljBf/ioXiErHr5dOIWFi5TSUuRjf/VRAgCcgITY4InqFpU0Ai
	WW77bUqYHQP5AaudJhfQZLue93w1fbHMlTFDlGUIz1mCbsHaQUczPw0mAm1m2gSD
	JjwsJiRCl50FH7YvuLKrqx+fZlmheImKAW41/QelInYuW/uwSjneR+HwWusz0Waq
	XCWYimPztuRVMMvw0RPPVCLrrtDJSibpMiC2eYZVYsXgT38gV3/12jYka92ehVh7
	Q8m/uPjEySKrJkrX2GTb63Bj96b4Imha1AmS0yXPQQkhYOoDT48+mgZShn2lcqqM
	cn7qSYIroNx1Kt3qIFbZg==
X-ME-Sender: <xms:XF1zaqG4Ihagay9KovRTpzLktorAZdoTFKqQpZkGGbXYuVWhaggHAA>
    <xme:XF1zamIWpExknCPzNBppG9c6lPgUmoyOm3980frecoYsjJIUr781gAp3JpS0xjVCJ
    zszRbskh917tYn5NAo116wkauJ4ylH-SL48Q0HDlPAR00OIJcHP8fg>
X-ME-Proxy-Cause: dmFkZTEK36Nx7j87NXKkFBqBnty+tNGgQukfyje13lHcFq+l5iXCPJQYN1qX9NulQ3oSIk
    fsP0lxQ6Ac2cdWhd0iJm+duA0peWusLgel8H/WMTjF/OGQ6VdrMO1LVewSDqeVrAiijTkZ
    P+cqeFtth2mu7q8JaKTEcJeFo7+BQVjwLFYxErVCDmNAZ34opbvZgmlJlvnT3+i3MRWDRI
    egQnYGPSBWaw4OP+boTH0UdTBO6RYe4ptQmMjz/oWLbhGZATvEF4d0kKtLuIuCtf01bBAK
    YLC/2qtd9aogweddBJd1uUo9OuvHDaT89SCvaPZ1N/gTs0pDQmarxxD85fUsoEPq0CZ7k0
    mDe2hEqe+SfDX86D2vzm6PL1Vkija/c5D/yyJYW6rxeOHJsbXgIPBQ6WlXnTNvXTngI60T
    Z5UDyNEKMeUn6+xcclipjTfEF38tYf3kzjwHoF67EV+ldp0YbHcM4mdDBQnS+00c5wBCA5
    Hh/ribq+AzoCtWtS9BCJGpXM+zEh9y8Un1yEPyqtlSpssg0X9bi/uPxzsGTMjY6GVqHa5f
    OpQqUtC1sJSFHb8H24NZkH9snorElXMf+SLk7gXmviNAHOZX1eVB+s3mkyWhe0HMSN9Wnb
    OGjaHFHsuN4zTo/GZ5DUr8YOFzWE4B7L74BITapx+nHk8N6lKFo5L73GdD7Q
X-ME-Proxy: <xmx:YF1zam1eZJ-9tZFSph9hL3KT7F5oGP-7Ei9lb_FyOJrB2O-DmG-9ag>
    <xmx:YF1zamho6O-2yVgRz2_XYAaWfkGqJ_xmwskyOdMtOwYt1CELPLkJVg>
    <xmx:YF1zau2f8oFJ6nHpQdlUNwYv27nQGGRmTLyqt4jV4rBgEvBP8jDr2w>
    <xmx:YF1zapeeva6IfT8LgXbZXaWE0aNd5oa31iRwnOzeJTpTLea-8YYzXg>
    <xmx:ZV1zahkaf9A1kpBXAkSP0_pWh_zatyZojCTATCVcGAMqQecMZKmFSY7Y>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id C597732A0062; Wed,  5 Aug 2026 11:57:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ag8nwV6tN_57
Date: Wed, 05 Aug 2026 17:56:55 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Heiko Carstens" <hca@linux.ibm.com>, "Danilo Krummrich" <dakr@kernel.org>,
 "Gerd Bayer" <gbayer@linux.ibm.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>, driver-core@lists.linux.dev,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 "Gary Guo" <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 "Benno Lossin" <lossin@kernel.org>,
 "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Trevor Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 rust-for-linux@vger.kernel.org
Message-Id: <f2002ee7-00a4-4a3f-a516-409886b724ab@app.fastmail.com>
In-Reply-To: <94c3ebc645e80feae1044a57b8b5c82d4d4ff408.camel@linux.ibm.com>
References: <20260803180931.97202-1-ojeda@kernel.org>
 <fb2daae7-4eba-4ca1-95a5-60f8157eb66b@app.fastmail.com>
 <DKFKXA6YWW8R.1NDZ44Q13XFQH@kernel.org>
 <20260804071330.24760Aaf-hca@linux.ibm.com>
 <33ecacea-ed2a-409c-ab1c-a136e06b1b7a@app.fastmail.com>
 <1aac654b8d333cc058a345b03ae0f798f1724ced.camel@linux.ibm.com>
 <57ac7553-4034-49e2-b686-b7272591da00@app.fastmail.com>
 <94c3ebc645e80feae1044a57b8b5c82d4d4ff408.camel@linux.ibm.com>
Subject: Re: `io{re,un}map()` build error in s390 under `!CONFIG_HAS_IOMEM`
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Aug 5, 2026, at 17:36, Niklas Schnelle wrote:
> On Tue, 2026-08-04 at 17:52 +0200, Arnd Bergmann wrote:
>> On Tue, Aug 4, 2026, at 14:21, Niklas Schnelle wrote:
>> - On PCI MMIO areas, memremap() and memremap_wt() should return a
>>   normal kernel pointer that can be dereferenced, e.g. for
>>   option ROM contents for a framebuffer console. This can't work
>>   on non-MIO guests but might work on MIO depending on which
>>   instructions are allowed those mappings (I can never quite
>>   remember how this part works on z, does this have to use
>>   pcistgi or does a normal aligned load/store work as well?).
>
> You still have to use pcistgi/pcilgi/pcistbi normal aligned
> loads/stores will fail as the physical address is beyond the memory
> limit. On the other hand the PCI instructions can't access normal
> memory. So you when using memremap() you'd have to know which kind of
> memory you're remapping and use the right accessors.

Ok, so memremap() by definition cannot work on s390 for regular
PCI devices, since you are not allowed to use readl() etc on a
kernel pointer returned by memremap(), only on an __iomem
token returned by ioremap().

One important exception seems to be virtio_fs, which uses
devm_memremap_pages() to map a virtio_shm_region, which in
turn can come from a virtio-pci device but is backed by
actual cached memory in the host instead of an emulated
PCI memory BAR.

>> This would not help with either memremap() or the !CONFIG_HAS_MMIO
>> issue though, right?
>
> I think it would help with memremap() because it would mean that when
> used on normal memory and accessed with normal loads/stores memremap()
> works and when used on PCI BAR / MIO addresses and accessed by I/O
> accessors it would also work. So it should behave the same no matter if
> memory-I/O is available.

Have you come across any users of memremap() that pass the
kernel address into readl()/writel() rather than accessing
them as pointers? This would of course work on arm and x86,
but is still a violation of the linux/io.h interface definition
and causes a compile-time warning with sparse. If these exist,
I think we just need to change them to ioremap().

      Arnd
