Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C708264615;
	Tue, 11 Feb 2025 00:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739235585; cv=none; b=Z3jXixbGjaVnFx3vCMDCWG9Tg5kKK0DV1CSRwyXeYF+wnl8UWltWHS4i96qMi51KLq0y10G72m8K24GKMaQtiH/5HC73VjYPV4zdnCSF9KSLT7PHyAtV+1rYT5L8i09HoZrOj+daXcFDzPkHmyhlYJndHe4bDRt+ywV6i2rzr6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739235585; c=relaxed/simple;
	bh=KclDnq0yGU1M84esdrfIpWZm2KXaxbIJOJXRdNM4TVg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P70KjpbM9vCrbsoXi22e5pk0Yau+5JnrGILDjRqzxkfijCbhl618VgZ4tGad59GC0LhAyOZb3d86JpnBozZmM/OmTzW3oO1VLR3vp0XpUkQ+KNFwd512gVKE5aj5S5SOZuyUNYVvYI+eyZJIYfmebUIQZ/wbx8uvceOEFm2bcmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=baX/QCOx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="baX/QCOx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68860C4CED1;
	Tue, 11 Feb 2025 00:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739235584;
	bh=KclDnq0yGU1M84esdrfIpWZm2KXaxbIJOJXRdNM4TVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=baX/QCOxqatyQmLiiwJbPKnXXqi17ksm24/KMF3E42PVYgHxp8UHyslMOHx/CleeI
	 +v8nfmXKDSFs5N/ZCQBxCGPe8GPQI+2dtJFBbvdN/txmjsnDEQ9v5e58ycEj+jULpA
	 tdXj9fX98XgZJpClPK3FcnfvIbruA7A8T6iv6Uqsac+/geicTGhqDS1Is3qnBTVHAs
	 gb/LHHm4EJjJ2y1osY7JMfGsufc+JLt6kaDcGFobRkKdawyQ5La6PEScQS3kdmUWfi
	 t8HRJPLYf6g0KI+jxc4cV9D+sj7EgQkzPmvzwfBDMshVoxQaK2deyXR+4TNxgWxz66
	 cOiutKCeDYFIg==
From: Kees Cook <kees@kernel.org>
To: Eric Biederman <ebiederm@xmission.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Dave Martin <Dave.Martin@arm.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	LEROY Christophe <christophe.leroy2@cs-soprasteria.com>,
	Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Kees Cook <kees@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	kexec@lists.infradead.org,
	binutils@sourceware.org,
	devel@daynix.com,
	Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH v5 0/6] elf: Define note name macros
Date: Mon, 10 Feb 2025 16:58:30 -0800
Message-Id: <173923550723.2947986.17868728802985188618.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250115-elf-v5-0-0f9e55bbb2fc@daynix.com>
References: <20250115-elf-v5-0-0f9e55bbb2fc@daynix.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 15 Jan 2025 14:47:57 +0900, Akihiko Odaki wrote:
> elf.h had a comment saying:
> > Notes used in ET_CORE. Architectures export some of the arch register
> > sets using the corresponding note types via the PTRACE_GETREGSET and
> > PTRACE_SETREGSET requests.
> > The note name for these types is "LINUX", except NT_PRFPREG that is
> > named "CORE".
> 
> [...]

I rebased this for changes introduced by commit
680e029fd62f ("proc/kcore: don't walk list on every read")

Applied to for-next/execve, thanks!

[1/6] elf: Define note name macros
      https://git.kernel.org/kees/c/7da8e4ad4df0
[2/6] binfmt_elf: Use note name macros
      https://git.kernel.org/kees/c/2fc4947bbd91
[3/6] powerpc: Use note name macros
      https://git.kernel.org/kees/c/609c8b309156
[4/6] crash: Use note name macros
      https://git.kernel.org/kees/c/0de47f28ec84
[5/6] s390/crash: Use note name macros
      https://git.kernel.org/kees/c/d4a760fb77fd
[6/6] crash: Remove KEXEC_CORE_NOTE_NAME
      https://git.kernel.org/kees/c/7e620b56d958

Take care,

-- 
Kees Cook

