Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795693510;
	b=ZVGqs9FKKtoFPP3Yla2ceRcUYRpQlHylayFG2+QvmE2UKYPfvRiBuVW9mLct86iVjN32
	 Ie1JXDBnHEtYx+djuTfLoGUki+nH3WkU9ZuMzrI1GHKJOKk0tK+Y7+2UtykNmdycNP7/U
	 PGK/CAUguHja6esx3s8JvAxU0QuPW+LkP6FhlENS7KBaQHe00U3h/wAQ8sePp8GlegN6X
	 ej02JparTjcyAU86RZBxqhMVS7/8QZIPWrpXnz4axpo5DDe87fh9cl/tIkwA8z7EiqQp8
	 bUEtVEIoi2Z3c6meDEI0zJiB793fGAYak8GPJKhjpkYqDA9nONzvM1ywSVkYhtwbXsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795693510;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=5BVeDoXywdonN8l0fahN7PgNc5xFYXRHYBZPC3PlIr4=;
	b=FQIXqD2h6S30DF2KnYZMWzg6JGgz1rG3UEJhXS2fkTLTKl7589u4NGLe8cqPMmkWelT2
	 0tB/a73jYDBZ2GjtSdhwbJ8yMnn5y7NJ4trotY4SEUO53wXyvTU+WnDuQEtAXb1AAr7qt
	 4QiliWqN6tdUSLUfPJMs402deps049ABrytb71AnQQ9/yTLu83+sdRxC1YltZtYMc/Duu
	 ZJvN681D5XQiXHPyEZaCnX0UVDcpi+X5WGvc5magQW8zhoOBafoB16alRu1C/eKZC+tZz
	 m9UWcu/FrFB5ExmejmObyCsYdc0Tb7aRc2U9hGmEwPFOEKrRKRzIZmLD7IbkFk060bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S2hH+FUi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A787F606A334;
	Thu, 26 Nov 2026 11:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S2hH+FUi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8741F000C4;
	Thu, 26 Nov 2026 11:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795693510;
	bh=5BVeDoXywdonN8l0fahN7PgNc5xFYXRHYBZPC3PlIr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S2hH+FUi1whGz3Tc5erJ4wvaQIsa7/tWSP/c6X9vu53OBUKo1B0WiNAclJt6yAFgm
	 pGz1Ex70shjn/h1DHItCYjmiSeUn89UCHCA4G1w1wWeCAdswE3zJrMKPMwFzKMZlDd
	 nC0SY1V0v4hU5bqu5wSTOQsO02ln/4LBS8/pU19gTTq8a94zu1u2oRzquyVVWvfoyJ
	 A9Q9F5dRlSSngm44CD8uAUW6WllAHTLL/ZABWNrv2paiBktHMVqFSwsqVP75fnKoBF
	 d/7+x6dvllgHhWRvd2tJbeHoIPzncqy0ud8b0/7wXvqdGK8WsxcZSCgR/1wb4XGsOs
	 rx6swYcSlIfow==
From: Mike Rapoport <rppt@kernel.org>
To: Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Paul Walmsley <pjw@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Rich Felker <dalias@libc.org>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Will Deacon <will@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	x86@kernel.org,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Cong Wang <cwang@multikernel.io>,
	Mark Rutland <mark.rutland@arm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	WANG Xuerui <kernel@xen0n.name>,
	kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev
Subject: Re: [PATCH 0/2] arch, kexec: declare kexec and crash capabilities in Kconfig.kexec
Date: Thu, 26 Nov 2026 13:44:53 +0200
Message-ID: <179569348034.4110350.10768570671103859123.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119-arch-kconfig-v1-0-37c276fe4d26@kernel.org>
References: <20261119-arch-kconfig-v1-0-37c276fe4d26@kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Mike Rapoport (Microsoft) <rppt@kernel.org>

On Thu, 19 Nov 2026 08:16:56 +0200, Mike Rapoport (Microsoft) wrote:
> The intention is to take it via kexec tree.

Applied to kexec-7.5 branch of liveupdate/linux.git tree, thanks!

[1/2] MAINTAINERS: add kernel/Kconfig.kexec to KEXEC
      commit: 09ade745fcd10af7fa62c73a918cae6814c5b0d8
[2/2] arch, kexec: declare kexec and crash capabilities in Kconfig.kexec
      commit: e583fcbe5b58597fdd81bcf150115fb801d6507f

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: kexec-7.5

--
Sincerely yours,
Mike.

