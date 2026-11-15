Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794726812;
	b=wIDt4XjqAdctczBXViXfVSilCfy1rwEV4DnqjexTaA9P4c2myHC9dlWqVeqEK42yQxBB
	 J6rHY9oHsxQN5YLT6qZasa3c/SQXC1C89HmFCs7ErKLVZz5JJ0bYTkYFMPhhxsPnAQ8Sj
	 yysV5tvp23u5JmHSnzoj2z+c7Fnbvh9EeWrD+d6eg7WeoYPGa4ulR4FBQvERojWVVBq4E
	 QdKmAj40r1ZsMx4AQy6VMiuz7xidzuUHMoIM668j4bQH+UDlp0g0UsqhHuPGb1sW/jKEQ
	 j9unYrk8f4XM++9cJ9KG48slRFzqcj3qQ9q42frCi2tK/ud2BoZVXedQiS/FjFpcOug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794726812;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=i0sztYeDoa78GRxByi5DPGRDZ13zK/I8mczcB1W5Z+o=;
	b=rMKXThKGTUXlQU4NbXqKGJQh/004ynmGHik5axkIRiP0AhWuWK5/JyNqgFVn71DneeCr
	 XR8KviHi2yh+z97tWrFe77HguXq+cjIISFKcwEXe8o+nWAi/EVPgbH19u0msP2n5pf6yY
	 IlncE6WwZf+o3JMqDldLN9BsAk3KyGISqCWMZzNE2wmzVL58UYGC/ye+150dQbukmZNuw
	 0mDP1ynvq8ttkJLarUXE5WSIYNPZH2ZMIenNbBdSgGgPM+ZgB5gh2go+S8ftDe6oOZpZu
	 cGkWNXQWAOYwhI0aXxCHEefzGXCtasMxtwbg97dfVivlvop/L/lhM5OkWDnIR4YLICw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f0EKiv+f;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6373C606A32E
	for <linux-s390@vger.kernel.org>; Sun, 15 Nov 2026 07:13:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6373C606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f0EKiv+f
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-36f8cdd30beso3116741eec.1
        for <linux-s390@vger.kernel.org>; Sat, 14 Nov 2026 23:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794726811; x=1795331611; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i0sztYeDoa78GRxByi5DPGRDZ13zK/I8mczcB1W5Z+o=;
        b=f0EKiv+f25sXRcQmBoiK+WsCsclD9PQHa+U5z3sGf3KR1sS3ZNEEroqRh6RNiac07P
         vGJPEugwLNmQaWqJhCPHikaN8XT33PRVwWCxE9PqkkLJA6butk39sYE2ryU8qCsIMdGI
         yo50td1Os6it0j1WrNa5HxnLEw4W7aO/qgSsYPJply/RpIro6UCSg0Mbr4ks/thyRkDc
         jq1OBKLqGUt/bM6QVBsbrIsF1mbjoO/AbvtSri1zHl8+S2Sf3KoNhgqJldsJW2yIuTc5
         6FJrXgJQKS6UwdWBKS3YQ4l597qJpRKbmN+vGilzta6Rl47F1I/gy3R+i3U13Lj6DU+d
         z+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794726811; x=1795331611;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i0sztYeDoa78GRxByi5DPGRDZ13zK/I8mczcB1W5Z+o=;
        b=bBO2vf0kxKhHjrlTVjgO6ECA/beiym0CeB4RTitbP5MuWB6v4SwOhLw/zDv6EFuvqL
         evO9NhL2XfTKYPywnYsjBCX3Va+PMJotNGCSNfzcb01xqwcsI697ARvxAE0L7wDibFCx
         Fyl3tV/Ql0wAYFZhSFmsVRcQvgamtKjVPDO7jOpHN3HsPoMa8h+R9TyC/hRnM2Xiwkua
         zpAGhEcIyRNV0MjZ++pflmxqSUtFImm83XFomPEn8LvSfTbmmDBms1qP5ieh86yi2CcN
         ywBjJ8Ohf7F9eU1ulnKjIn1K8AWn20bFxtgmN/dkCuDpgZO1mKXeRhXeXNjDquGmA7y4
         /nXA==
X-Forwarded-Encrypted: i=1; AL+hErE59sixzBGk9omszzxpkQRK/lWP7zUuFLYyeR43+Gr9qJLW6LKZwIxZy88udDNvRpHrQPDd1HolmPl5@vger.kernel.org
X-Gm-Message-State: APuU4Z/32k14JAGt3zCTJhiEPitEreBZOaZmGqN7D+St/vvNf6zo6Zo+
	YVEIWD9AcC3IgDMe0QklBb0ellIW/D18usSKeCv8XFN+p3LLha3Y08l5
X-Gm-Gg: AYBFou1HZj0NxylIiQZ0GDVlr+IZbGSHw786HAkKEl29A+4MNFDJDnXXnVFN9kZb6ea
	cxURnTX/Vo1Mf+WZ4Wr1ssdoM+HhtCS4UA+8DzTW7QN4c+EKGhrGd0K+Q6qvAW+6yf9m1Kxayi5
	Juq/ekw9a3+0aaKnsenH9eZQQ2GsN0nGjdLfapMvipm9PefRpxR3QFnvRfdJtsIufOhv+6DygUY
	9938VA9bNVUOIDxyrMAJAXFhX1KcebEy/l+0xsg4ysSJgq0y5V+7I4jSXHMUllH2uHVN9A7PIT3
	S4ddgJ+JlZw62dcp203yJ06/StelJ0+4pw6Uxwa8Nbo1QFu2GPgLMM2TBeryUnoRy5gFkIaBn2g
	avVl8J1B/xr0HplECJAik9q7BTgWMsOid1eS15mCNPX1iSprb74hyVLZij1WQg5f+0Frrw2eO/4
	uSTwMyaFZpNb5VAa22kQlvSEtRZfPuXdKYDsnp8GlwD7GVENlpBpY8z3n4AlRwwnrjPpYyE/Jle
	pwIf7YK8ZE1ueE91mPNwZMHf03nHtq6hgd6tpMMIDIVm5cwA542+032tfb1/nVk1dVcIXOz76GA
	hcpWeuk/oUGNSnStVJqA3SR0EJw=
X-Received: by 2002:a05:7300:6148:b0:36a:7bb7:4609 with SMTP id 5a478bee46e88-37967dd7e1dmr11471490eec.34.1794726811302;
        Sat, 14 Nov 2026 23:13:31 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37956bad134sm27441185eec.27.2026.11.14.23.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 23:13:30 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Mike Rapoport <rppt@kernel.org>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexandre Ghiti <alexghiti@rivosinc.com>,
 Andrew Morton <akpm@linux-foundation.org>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, "David S.
 Miller" <davem@davemloft.net>, Dinh Nguyen <dinguyen@kernel.org>, Donald
 Dutile <ddutile@redhat.com>, Eric Chanudet <echanude@redhat.com>, Heiko
 Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Huacai Chen
 <chenhuacai@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>,
 Liviu Dudau <liviu@dudau.co.uk>, Luis Chamberlain <mcgrof@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Nadav Amit
 <nadav.amit@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Peter
 Zijlstra <peterz@infradead.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Russell
 King <linux@armlinux.org.uk>, Sam Ravnborg <sam@ravnborg.org>, Song Liu
 <song@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner
 <tglx@linutronix.de>, Will Deacon <will@kernel.org>, bpf@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 loongarch@lists.linux.dev, netdev@vger.kernel.org,
 sparclinux@vger.kernel.org, x86@kernel.org, Madhavan Srinivasan
 <maddy@linux.ibm.com>
Subject: Re: [PATCH RESEND v8 11/16] powerpc: extend execmem_params for kprobes allocations
In-Reply-To: <avlTdlK9ErlqVRYl@kernel.org>
Date: Sun, 15 Nov 2026 12:33:31 +0530
Message-ID: <4idi8tks.ritesh.list@gmail.com>
References: <20240505160628.2323363-1-rppt@kernel.org> <20240505160628.2323363-12-rppt@kernel.org> <3f7af771-87a7-4ae7-9919-bc4c23bd31c9@kernel.org> <avlTdlK9ErlqVRYl@kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mike Rapoport <rppt@kernel.org> writes:

> Hi Christophe,
>
> On Fri, Nov 13, 2026 at 03:36:01PM +0100, Christophe Leroy (CS GROUP) wro=
te:
>> Hi Mike,
>>=20
>> Looks like I missed this change ...
>>=20

I didn't initially get what Christophe meant here. Then I came across this
reply of from him[1]. So looks like somehow between v3 to v8, something got
changed?=20

    On powerpc book3s/32, vmalloc space is not executable. Only modules=20
    space is executable. X/NX cannot be set on a per page basis, it can onl=
y=20
    be set on a 256 Mbytes segment basis.

    See commit c49643319715 ("powerpc/32s: Only leave NX unset on segments=
=20
    used for modules") and 6ca055322da8 ("powerpc/32s: Use dedicated segmen=
t=20
    for modules with STRICT_KERNEL_RWX") and 7bee31ad8e2f ("powerpc/32s: Fi=
x=20
    is_module_segment() when MODULES_VADDR is defined").

    So if your intention is still to have an executable kprobes, then you=20
    can't use vmalloc address space.

[1]: https://lore.kernel.org/all/1cb41761-29d0-5d33-b7c1-0ca3acaa810d@csgro=
up.eu/

>> Le 05/05/2024 =C3=A0 18:06, Mike Rapoport a =C3=A9crit=C2=A0:
>> > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>> >=20
>> > powerpc overrides kprobes::alloc_insn_page() to remove writable
>> > permissions when STRICT_MODULE_RWX is on.
>> >=20
>> > Add definition of EXECMEM_KRPOBES to execmem_params to allow using the
>> > generic kprobes::alloc_insn_page() with the desired permissions.
>> >=20
>> > As powerpc uses breakpoint instructions to inject kprobes, it does not
>> > need to constrain kprobe allocations to the modules area and can use t=
he
>> > entire vmalloc address space.
>>=20
>> Using breakpoint means the segment must still be executable.
>> On book3s/32 VMALLOC segment is not executable, while module segment is.
>>=20
>> See commit 6ca055322da8 ("powerpc/32s: Use dedicated segment for modules
>> with STRICT_KERNEL_RWX")
>>=20
>> See report and fix at https://lore.kernel.org/all/ed03d290d440d579a81ae0=
b7de5243721291d903.1794543909.git.ritesh.list@gmail.com/
>
> I'll take a look, thanks!
>=20=20

Thanks Mike for taking a look. Sorry, I should have ccd'd you there, I
guess I missed it. However, the changes are these one here [2][3]

[2]: https://lore.kernel.org/linuxppc-dev/82c4973addebd82923c460cb44221f5b7=
6146afe.1794572365.git.ritesh.list@gmail.com/
[3]: https://lore.kernel.org/linuxppc-dev/f75f2cf97f44375fd2c8820e0caeab703=
cdb371c.1794572365.git.ritesh.list@gmail.com/

-ritesh

