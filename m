Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795384612;
	b=R9HX3uxqhJpqMe8WHKZnD7nDbkTvNEvkdiPuhJBRohz+hS1xKGj1U0XSbOkaSgeSykd2
	 AXpkmfItqTUHQboV1RL0Xua8d28f7LqcnHD4WiBL6Pt5l7yx38WhE6j3+p46KvCg36uD4
	 7F43Y59SOYmTHLhW/NpGlD6wgKIZkI2FhH5hDA+dQeLkWwJJ7M4DQNbpKngGcYnSLMgAa
	 xHO07MXgJFif9JtntdkqsfR0/lWOi5bkA6k0F2/nWo/Ljszq2SCVazGNdSrQbuELQPY7K
	 p42h5AEQDptj8GMHNrsnTR9WzF12GdnQp6ecxqqVkpV6tKIGoyxxmGunrBtErzSs3bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795384612;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:X-Patch-Reply:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=bwqVDHaqqXUJecFoI8gfarhhx3uMgHGFcxRh37PQR30=;
	b=DxAIP8oBsZx16Q55Gw1gBpzuv7rRLRHNkyboJpSU0lBk5rUrUYuLjMNWh9fXxecCVnCC
	 9c7sdYUTXUDo0r1qoppIm5v0FRVFmuzKCa0+v6YhpRUTDMc5CQCXnqe8NmNvU61ZLR3Hv
	 tRSVSH0ckeSw7VUoW4c6kW+TEibMODi2NxTO4IujMTlvm29n1T0+8YsFEE/rAvzi+2CxT
	 sgFJkIaFLjE3qemWpGEPg8IEJMIwg1dr26SCUOahpw8cXteTtCOogZRx5HAf5n766sntq
	 52QF1dOZrunhEui8oi4YGEiWs1MZd5xbbCaJSccnYKoKtiL7ViyJxnJW1P+C+MLuing==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BXie8At5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C91606A334;
	Sun, 22 Nov 2026 21:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BXie8At5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085171F000CF;
	Sun, 22 Nov 2026 21:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795384611;
	bh=bwqVDHaqqXUJecFoI8gfarhhx3uMgHGFcxRh37PQR30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BXie8At5QFQ5VGJ5Wgxa+Ryfj2HbGOJ0KDHW1aolgsw2YtdZGPnu8WYcSmeFf9iTy
	 5wiX3oWysPjoCke2hcQZDizPm34+kAe7FMjSaSZ9srwusVIqRO580db6LxZDAFaZ0+
	 3aDEW76QVsDdxoBaJCF/eDmBo7SUv8nl1byepex6XqNbxhpJHXHoKY2hbT2kLTC95N
	 7JnRNOt0TIdCgaQhdXGjEOlBwvV7HGnUumRRGA3StMRgzFJT0plPL8HRWUST+VQqvd
	 X4RjTcvHCj0K1oKGcN/z3PbXWOEFtUMKW6QRQ4AjrpymszI4/3zzB9pQMRd26c47gs
	 kxUaKiE3hZ+vA==
From: Danilo Krummrich <dakr@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <kees@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Srish Srinivasan <ssrish@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Nayna Jain <nayna@linux.ibm.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	Alexander Aring <aahringo@redhat.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	driver-core@lists.linux.dev,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org,
	linux-s390@vger.kernel.org,
	gfs2@lists.linux.dev,
	xen-devel@lists.xenproject.org,
	linux-mtd@lists.infradead.org,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/9] Add __must_init and require explicit kobj_type::release
Date: Sun, 22 Nov 2026 22:56:39 +0100
Message-ID: <20261122215639.1178566-1-dakr@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119192520.1983406-1-irogers@google.com>
References: <20261119192520.1983406-1-irogers@google.com>
X-Patch-Reply: applied
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 19 Nov 2026 11:25:11 -0800, Ian Rogers wrote:
> [PATCH v4 0/9] Add __must_init and require explicit kobj_type::release

Applied, thanks!

  Branch: driver-core-testing
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[1/9] Compiler Attributes: Add __must_init macro
      commit: b8a53320a885
[2/9] powerpc/secvar: Add missing kobject release callback to secvar_ktype
      commit: 4d5d4dd2a2e2
[3/9] sh: sq: Add missing kobject release callback to ktype_percpu_entry
      commit: d19384f2f3c7
[4/9] cpufreq: governor: Initialize kobj_type release callback statically
      commit: 009365942c15
[5/9] dlm: Wait for kobject release before freeing dlm_ls
      commit: 48ae948f4285
[6/9] xen/sys-hypervisor: Add release callback to hyp_sysfs_kobj_type
      commit: ecaf88d385c1
[7/9] ubifs: sysfs: Use kset_create_and_add() for ubifs_kset
      commit: 25d952902dee
[8/9] drm/amdkfd: Free queue in procfs_queue_type kobject release callback
      commit: 6d4ff4a020cf
[9/9] kobject: Require explicit initialization of struct kobj_type::release
      commit: 45eeed1f8094

The patches will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patches are in the driver-core-testing branch and will be promoted to
driver-core-next after validation.
