From: George Spelvin <lkml@sdf.org>
Date: Sun, 31 Mar 2019 09:23:14 +0000
Subject: Re: CONFIG_ARCH_SUPPORTS_INT128: Why not mips, s390, powerpc, and alpha?
Message-Id: <201903310923.x2V9NEmC017398@sdf.org>
In-Reply-To: <20190331003020.GO3969@gate.crashing.org>
References: <20190331003020.GO3969@gate.crashing.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="--EVF5PPMfhYS0aIcm"
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The kbuild test robot sent me the following compile error report,
indicating that my version test needs further refinement.

With GCC 8.3, I get in-line code even for variable shifts:
mul_u64_u64_shr:
.LFB3:
	.cfi_startproc
	ldgr	%f0,%r11
	.cfi_register 11, 16
	mlgr	%r2,%r2
	ahik	%r11,%r4,-64
	srlg	%r0,%r2,0(%r11)
	sllg	%r1,%r2,1
	lhi	%r5,63
	sr	%r5,%r4
	sllg	%r1,%r1,0(%r5)
	srlg	%r4,%r3,0(%r4)
	ogr	%r4,%r1
	ltr	%r11,%r11
	lgr	%r2,%r4
	locgrhe	%r2,%r0
	lgdr	%r11,%f0
	.cfi_restore 11
	br	%r14
	.cfi_endproc

... but apparently gcc 7.2 needs helper functions.

Anyway, forwarded to
1) Invaidate my previous patch, and
2) Hand the ball to people who have a chance of
   doing anything about it.

I can try working solo to create an s390 kernel that compiles if
people really want, but I need assistance for boot-testing.

Is anyone interested in heping pursue this?
