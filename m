Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A6B35E55D;
	Tue, 26 May 2026 15:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779808939; cv=none; b=W8GQv0AuFmSKs9I62MsKB1Rjtg69xPp6dhuGfkxvlY8oubrT0bJkun19UdlOt9B+yaNBPJTF8lR9kHHe7aT2FN7wSZQ0NL7VzRGUOGSQ2VH6kKjyOpvYahmwVk3G0M1a5AS6aNu3Fuglniv35x/6FJM00DOjHTPRYt7fEr5otNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779808939; c=relaxed/simple;
	bh=ZkuDvku83t97+XBYhvWo9Uns8mWKuzVanjRuYZy6FiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cnA2rI+n8uWGtpGRCZJ86bGwV+b/DP8M7mqQzg7Q2ZpNbSCJHT7nivtuBH40FZXXomLoqUxWRC7wC4/JKl1lwJEt+boqNNBJKxm5xO/Jbsq3m6PtWuyfIDHZyMDpK0s3GhNZCxxGrNGFwbNPaGLAwiBkuPJlZyz4TItmTByIEVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kg/XUJJC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kg/XUJJC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B364E1F00A3F;
	Tue, 26 May 2026 15:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779808938;
	bh=uDm3SE+wj14K2ZLchywSqxzxQe3Kn/14VxTpFaIuLFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kg/XUJJC6RliATTRDG0SVtVXqL+gpknSIcmVOIoKNykD6tNqjBAEFeaE7bQRoUg5A
	 9EdvJ9xYw4dInTc8CofmzQ8GnTo87jmZS8kEdpTaTJYFevP0X7MLEXCCjo0mGj0mT7
	 rPvjp+13uK+UU1Mm5OMSFcbh9tWK8rDBm7KERjYtQQjvZtfCmTjLRCebIV5EogIPQg
	 c3gKSlvVdCpe3s2vu16yD83meu50VgSFQQr1lpoeFYUpNHNBViKWdPeONvd+pf9ZnK
	 1mZIO8lAO2+6kKzBapZUUV6oG2DSjvGEP2jdFRT0ENGHv3HDMcxno+wRRuXZMnoFcg
	 wOYbyp7FLadxw==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0BE25F40076;
	Tue, 26 May 2026 11:22:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 26 May 2026 11:22:16 -0400
X-ME-Sender: <xms:p7oVamcud7pgeqZUyckTJfI-qxiv7-r60UkN-iJNwGbsB5as_pFxfQ>
    <xme:p7oVajTiDBFAkFvg8mQ5-CxOFNzMM2Z15yRDHFlQI5ID1EINDweWer6IYj45uCX-v
    F29n1fmPnKptN1rEW7FRytcbH9t44T1EPhcBhEnQ8cwmAGm-XliGA>
X-ME-Received: <xmr:p7oVamzOQzk3zJnfjgT2N6ww_jYglzmn59q69o-ME8k41RENbkZq4OGLGUPwyY0K_YB7MyB1yON1ds3SRPVXfq3hoZl0pQbq>
X-ME-Proxy-Cause: dmFkZTFpmA1McbnqjIdDoCcC8/dKh9RDeYcaA/XB6dgQZoHsdisS7Rnte/RUY2pDCqsaCf
    lYH/GXfkGRmzTYnB4S+g0DoIzy4KUSXH1v1hqWsXA4v5WIAvvT6c8zNgUsod23Kpq2+47O
    yYMzbMVdimQJPpKCDvwUMQiSwLgkBGzQ1ckebHI5CwcU5PXtm0paPap1/zDmdG+vWcQc/M
    pmWI2idDed0xMRSQV9XOsN/PBFcH6SBYELvyO/AtrMtpHg8r71AQlMzDlEp1H1iVazK3oS
    DonyrliF9qRbQD87XBn6QOt2bC/09pqeijaNsBJFU0GwQ/sar+bEYdVoRVtkXuEiBwHIRY
    NvmRzh3HKhTixLa9Yn44SeOJDKNB4emdE7Zg6eb6qu0SJAJyYk7TBJPpbtw/8VWjWgRilP
    LwsQlLqbO47h14uao9G3vhgfKyEJrZKGPAdXvTlqYclnCbpAmE2nXMAcxfN0wHm76Lme6N
    Iowx0J9CdnEy+E189qIJZ5I9dE4gMQBaqH1/S62Ot9HGBFylDe3CpM4uEAUHkRI0uUEOi1
    wh+Jq9LdZKZrCAHLtoZKbuj1vubHqyERkwPxdgYDLYAlHqxQsggXqKiHFgg1xD6KC9fGFr
    utR9wT6WMzr3FFToF4LzVvv9rilxQmyrMtcdfdcqAwv3Hg6NWmB4R0Co56bQ
X-ME-Proxy: <xmx:p7oVahpDGALUJdREfN54wvpzznnoUF7Gi9DmePljRr-Z_uIhaiMtBg>
    <xmx:qLoVaq5ab9r-MEakB--S5SHZpLWigHu_Df_r6xeQzMc5IEAHUTXhIQ>
    <xmx:qLoVatu0qbUg-cPV1_hi7dgcI-S7Fvbsem4NnsnOr1vG2ZdX-HjDkA>
    <xmx:qLoVamBLBIIzTwzY-PP0nhOcghsWnEUEioe_52dAEWHoCa93MWv0iw>
    <xmx:qLoVakjSVAxH9BkMe-6C46t2Nzd4lrZF1RwFgvoAVZdaeHvi2e9uvXpn>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 11:22:15 -0400 (EDT)
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
	Sohil Mehta <sohil.mehta@intel.com>,	"Xin Li (Intel)" <xin@zytor.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,	Yury Norov <ynorov@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org,	linux-openrisc@vger.kernel.org,
	linux-s390@vger.kernel.org,	linux-arch@vger.kernel.org,
	bpf@vger.kernel.org,	linux-kselftest@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	Daniel Almeida <daniel.almeida@collabora.com>
Subject: [PATCH v2 09/12] sched: Avoid signed comparison of preempt_count() in __cant_migrate()
Date: Tue, 26 May 2026 08:21:45 -0700
Message-ID: <20260526152148.30514-10-boqun@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260526152148.30514-1-boqun@kernel.org>
References: <20260526152148.30514-1-boqun@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently preempt_count() is always a non-negative int on all archs
(PREEMPT_NEED_RESCHED archs will mask out the MSB when return
preempt_count()), hence the checking in __cant_migrate() is in fact just
checking whether preempt_count() is 0 or not. In a future change, we are
going to use all the 32 bits of preempt_count(), which would make
negative int values possible from preempt_count(). Therefore convert the
"> 0" comparison into a zero checking to prepare for the future change.
No functional changes are intended.

Signed-off-by: Boqun Feng <boqun@kernel.org>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 75dba7cc09bd..636e6a15f104 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9207,7 +9207,7 @@ void __cant_migrate(const char *file, int line)
 	if (!IS_ENABLED(CONFIG_PREEMPT_COUNT))
 		return;
 
-	if (preempt_count() > 0)
+	if (preempt_count())
 		return;
 
 	if (time_before(jiffies, prev_jiffy + HZ) && prev_jiffy)
-- 
2.50.1 (Apple Git-155)

