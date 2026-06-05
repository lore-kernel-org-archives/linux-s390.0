Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A983FFAA4;
	Fri,  5 Jun 2026 05:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780638106; cv=none; b=JqTekq4qeFeOtjH/MGUWCvixT+TwdPklIxUWJ6wwKsMRF/gJ42RkIP1+FQOFwfruRw/lepBfE0+BYUXH2VP7TDXlSp2ZkgxzV8mNII0AxzST23L84+rG8ZNKr71HKKzWWHws0lfFsE1ZyzMkiRgiXRkUyQwxunJ768k5hzcLPoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780638106; c=relaxed/simple;
	bh=MbtvuBNH3GysMzOJRSBr0Nwx1iy6lfFNP2fljYwUfY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FeGrI3N4IfKJZqJZhY5z1n4mhEJHpXLIMac/vho/FDEdra1YEnxJ1YkVYHUCBatg84bC+JHysD32sVPyIfeiQEQzuB8OX6Evihh5jgwaQ1QIWim1sEtvlI5ptlXA0cGsv3zz+Y9lzdyIZHfYcYjq8ijkQoU2KjsUr22+lUusNyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJLeiJLp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJLeiJLp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D277E1F008A1;
	Fri,  5 Jun 2026 05:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780638101;
	bh=3bY5pS2rVgQa9nC8tbPnRn1j/SHdGkv637KqxwEbuVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WJLeiJLpGTULrGaD3KJ5ZO/qhAD/WTXhS88AlVTFLOs0aEjG5xtuCJqqos8RhJbat
	 mhChDxDbwYUJxeI0ODSa/E0r5b1XWCOKqOdT25UJhv6TGQix4wMpvjFST/D5kTuJFk
	 27FwOTqTMEKtwJN2N6W9wm5pWcOYnYuG7OU6u/Y/VwZaGJ047neU3hDZOzt+uJ3rsl
	 G9u+LiEKJRa6WeYT4eVdlb5WPAX6/uTHy7tzVCKVlsdS0xFwBLqATE+4bnJVyYww1Z
	 3y0kwJU7MisSREttB7QzSQ6+O2nrwCPqi4p6ikyNj17aW5wdwTKN61KaHzmEPIHFLT
	 vKcGr7z7vAMsg==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 26FE3F40075;
	Fri,  5 Jun 2026 01:41:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 05 Jun 2026 01:41:39 -0400
X-ME-Sender: <xms:k2EiapF7hlZDOAuYu1xlaWFvcJpn8Cm5ugjMNMJOagiFqAYdbByCPg>
    <xme:k2EialJVF-ZtJPh1V3OUR0_zu6n4HpKdeYgdMK6l84mTGY_gK7pyQYiNuCFjZ2wg4
    5S8bswIlx3N_yM8KbJyfQMaTVRARomPBIZkFWCzf2mGxZpLXY2mLQ>
X-ME-Received: <xmr:k2EiasXzSUJRLCKRSIBhhiulg3FNaSdfob9iET4hpfjWEX8GvyzYYdWfMRs>
X-ME-Proxy-Cause: dmFkZTFCwYGExB8+n21rrRlgZz2BZEPfw3mIE0bRNe76RMQAdH8f2KDaPLT52qZo7gxyWp
    0wXQACdPWdspv4jN5UYFCpihH+vrJtJ5nM33JJDnQyPnqbA42Pv6gENFpmiA7vDUbZDCAC
    N+ZmE7MklGAiGBNJA045y18Z9khhPwbxKZPuahNIwIz69+nOH0m/THs5eb4pu9rOFYQQI9
    b1h3voWmc5QUasjwQpRDRo+W3jNrB4TeCrmSTmM73SZRB0LYstjQaA4JitE82TBWNXKOy5
    NeQugQn5+UA17tSJ+MYIgsz9Sw+H8LaFdylvI7Cq2OhiaEqC4YLyUJJOJm9vOjE+2O1Njz
    jp4sreZDsZ269nsz2mo/kcC7coE3T6hddbvivsAbKivqCFPV3/0vs6kZgVMc2e9TJrhRt4
    fHYKqMx8M1PZxSYs7AntkRGfCKC7aBsXRQ6kbOk1KsC10Ei1hZZuLRE8BTnXhSkdEHM54H
    lhpM6NGWlljg7EPOyVAxg2wG6/DdZVDRtaWTY3aH6bYu8JoW+/jY1i4UdVw5IgTsxxQHR1
    ltgW9dvVp0pCbLg/ftDSu7Dc+bAfuiwlzk6SJccnFUDu09D5+4zqk8qhwu9T3M94LlcZXi
    jn3q9K0ZJyPphv2GjNN8d5hWgag33nJE1mZKYhWRYKxAOyy1OdD4jaybX7SA
X-ME-Proxy: <xmx:k2Eias0jMk5GlOmh2DXtBQ5-5tzjEw9qSOBxOxEgsYizTC0ECdEugw>
    <xmx:k2EiamoqF-zDWQKbkEyB1dqrcB2cUwWkm2thwUYyh2wufveCu9AkkQ>
    <xmx:k2Eiao_sY7kt7z2Q1-2nU-EK_BZpV2cLs3RLyBW7YCsXhyIApA9sMw>
    <xmx:k2EialnCWn-F4YFUJBMWw3EtFjhK3cGFSYQpUKjiHcAcLfU1WL_gcA>
    <xmx:k2Eiaj5M9ptUWrJTGR04zTPVBfdJXeqhGffyzzQAFSVHZjVACJC7NSX5>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 01:41:38 -0400 (EDT)
From: Boqun Feng <boqun@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,	Will Deacon <will@kernel.org>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,	Arnd Bergmann <arnd@arndb.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,	Miguel Ojeda <ojeda@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,	Jinjie Ruan <ruanjinjie@huawei.com>,
	Lyude Paul <lyude@redhat.com>,	Thomas Huth <thuth@redhat.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Nikunj A Dadhania <nikunj@amd.com>,	"Xin Li (Intel)" <xin@zytor.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,	Yury Norov <ynorov@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org,	linux-openrisc@vger.kernel.org,
	linux-s390@vger.kernel.org,	linux-arch@vger.kernel.org,
	bpf@vger.kernel.org,	linux-kselftest@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH v3 04/13] openrisc: Include <linux/cpumask.h> in smp.h
Date: Thu,  4 Jun 2026 22:41:19 -0700
Message-ID: <20260605054128.5925-5-boqun@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260605054128.5925-1-boqun@kernel.org>
References: <20260605054128.5925-1-boqun@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lyude Paul <lyude@redhat.com>

While OpenRISC currently doesn't fail to build upstream, it appears that
include <asm/smp.h> in the right headers is enough to break that -
primarily because OpenRISC's asm/smp.h header doesn't actually provide any
definition for struct cpumask. Which means the only reason we aren't
failing to build kernel is because we've been lucky enough that every spot
including asm/smp.h already has definitions for struct cpumask pulled in.

This became evident when trying to work on a patch series for adding
ref-counted interrupt enable/disables to the kernel, where introducing a
new interrupt_rc.h header suddenly introduced a build error on OpenRISC:

     In file included from include/linux/interrupt_rc.h:17,
                      from include/linux/spinlock.h:60,
                      from include/linux/mmzone.h:8,
                      from include/linux/gfp.h:7,
                      from include/linux/mm.h:7,
                      from arch/openrisc/include/asm/pgalloc.h:20,
                      from arch/openrisc/include/asm/io.h:18,
                      from include/linux/io.h:12,
                      from drivers/irqchip/irq-ompic.c:61:
     arch/openrisc/include/asm/smp.h:21:59: warning: 'struct cpumask'
     declared inside parameter list will not be visible outside of this
     definition or declaration
        21 | extern void arch_send_call_function_ipi_mask(const struct cpumask *mask);
           |                                                           ^~~~~~~
     arch/openrisc/include/asm/smp.h:23:54: warning: 'struct cpumask'
     declared inside parameter list will not be visible outside of this
     definition or declaration
        23 | extern void set_smp_cross_call(void (*)(const struct cpumask *, unsigned int));
           |                                                      ^~~~~~~
     drivers/irqchip/irq-ompic.c: In function 'ompic_of_init':
  >> drivers/irqchip/irq-ompic.c:191:28: error: passing argument 1 of
     'set_smp_cross_call' from incompatible pointer type
     [-Werror=incompatible-pointer-types]
       191 |         set_smp_cross_call(ompic_raise_softirq);
           |                            ^~~~~~~~~~~~~~~~~~~
           |                            |
           |                            void (*)(const struct cpumask *, unsigned int)
     arch/openrisc/include/asm/smp.h:23:32: note: expected 'void (*)(const
     struct cpumask *, unsigned int)' but argument is of type 'void
     (*)(const struct cpumask *, unsigned int)'
        23 | extern void set_smp_cross_call(void (*)(const struct cpumask *, unsigned int));

To fix this, let's take an example from the smp.h headers of other
architectures (x86, hexagon, arm64, probably more): just include
linux/cpumask.h at the top.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Acked-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Boqun Feng <boqun@kernel.org>
Link: https://patch.msgid.link/20260121223933.1568682-5-lyude@redhat.com
---
 arch/openrisc/include/asm/smp.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/openrisc/include/asm/smp.h b/arch/openrisc/include/asm/smp.h
index 007296f160ef..84653aaffa96 100644
--- a/arch/openrisc/include/asm/smp.h
+++ b/arch/openrisc/include/asm/smp.h
@@ -9,6 +9,8 @@
 #ifndef __ASM_OPENRISC_SMP_H
 #define __ASM_OPENRISC_SMP_H
 
+#include <linux/cpumask.h>
+
 #include <asm/spr.h>
 #include <asm/spr_defs.h>
 
-- 
2.51.0

