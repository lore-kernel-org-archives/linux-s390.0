Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EF3397942;
	Fri, 18 Sep 2026 06:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789713337; cv=none; b=BxFO1o/Wm8IPlxg2b9X6g8/mevcG4VGpOEWNOhI7urXDj9ONoSIR2i/5tWZNpCYjkr0sNFKqWjFzcLD6+ARxAsaFYdLXypUSO3lQOdHp17DjI9flgxsR4uwdGRC/p0KKMyVFmI0arLwfdETptfcHNQOzGcd4DtiONFWdVPKtr8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789713337; c=relaxed/simple;
	bh=PXz+AEyINuj82u7Q+9uDxzw7nkGTATvc9XdXGDT6JAw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=fOlcfsOTMCJpLOorOa9S3kpiPUOJt9JwdHQaPqpy5N+C1jKlQDDOxG6khIbyYyd+GceQhzSPOx7K7JB+aGcDocbkSavyFIPPpnGjzbcp3IK77gvoHKJhIZgv2e48mhGEasqRMir+ad7kQd7eFZORanimUosIyPLKri73MpFRGr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=PZNLjbBC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jBqsFaXf; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="PZNLjbBC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jBqsFaXf"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.stl.internal (Postfix) with ESMTP id D6A7B1D000AB;
	Fri, 18 Sep 2026 02:35:33 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Fri, 18 Sep 2026 02:35:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789713333;
	 x=1789799733; bh=5lJK4CWzfgszxTPisa6n5iUQCQ94cJhqVE7BI7tdaWg=; b=
	PZNLjbBCMu1kqgjWF6oXBRM9h80jaEps+8D/s7cSPlLAs/sBQ5lnKk8Pk0HyZPv8
	M3zgYz1fkgSlhbPiN213VmuGAfxgvNf8y7ARP8T0aE7tDxr7BkDIpNgq1dYiWQm8
	MwFWuSHbj8yMPwV5gxhfswCpxcMrh1JJIRbdav3X3gHgJ1CZlOWwBryTNP1ffMXu
	b5VfbPnjKl+Heug3ijEiJa+D7nqfKgzEZl8uQjmISFVpKg6rdWK9rlki8ivux93U
	Ldh9FLUDwmWhu+lsLs0MmD7bow696fppq6h5H1E2NgUwVwOyjYNxLTuJF2p+tWWG
	AR7T83/40+yoilib1QTpYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789713333; x=
	1789799733; bh=5lJK4CWzfgszxTPisa6n5iUQCQ94cJhqVE7BI7tdaWg=; b=j
	BqsFaXfVCyrtvbi5Y6lC4hMl68rWtblBrrKjUk78t0QYf9dWs4mSv9hZcTcdCPXl
	jHH+TbkZKs3Si2SNTeC/g8SiJtUW7kSe6t5ft4YmiQU+B4bFdGgFWGYHBDSLlH0J
	TOOe2G0//RDTOP9/RHFvrZTpNhscgjBl2IQoRvxe+cenEnW4LRp98ehtp/QOrM/C
	j1DBl7IBQZxhk6M+x3HDTzV8Au9cgiDhOCW0U+ivdLZdvQ2RNhxYXbX0FxScrTDK
	CRvigoxUSkZWcvlKkxt9GTHHnkiuZ29SQf4aukA+giKtCTukZy3ZaJ9g8Mcn0dqj
	m+NT79Kqqmsswy6VgLdPQ==
X-ME-Sender: <xms:sdusarw6CwLcecS-ZOF_o4k98NTg6eh0X9BPyLwzzjIiOHj9dCmYmw>
    <xme:sdusauG9a_6eIdWK_wkUnWMe2OBfk4EL06wuReja2xNIn4HqosArcIWozES6Jt2gQ
    lxqDL37Ii29kHtO6inQ_StZIUxH2OGt3O4JK70J7rmchYaVLM7siYWSeQ>
X-ME-Proxy-Cause: dmFkZTEIIFgx0WbGNQ58MO77NMw9OaJpm9DbTqlfAPRrCqHLxA6h610PWouYKfQMP0MfHZ
    FgQIsgI0u9YWNsSUq7uGJgu6iUC9SCqsw86qV7DYQofAPbgRXdmRJM6RI6byfBBg9PRit5
    KCJGRtLDg4pN4dasBDoDu8jHTYonM59/m2QOwzjRgs+iYjbk19vxRZsy1S6HQZRvO0xGos
    jxoESYgqiB8fdjTYVCbNlR7JenOOBTkAWFwjjPh8iem+0zFyZlwR0Csf7s14XiC1stoQDX
    gNCN9LVvWR+UjAOcTK5bozPGVRl+y9bxAeENNDi6uGVTvRMvw3ZC5+sva1VamJd5zwGSjT
    Bv6D6/W/6JD3jk+vLf4U+b0bfUXiH2aAMvSYESeF1fRokMs9Ao8ElVDihgD4Ybgd+Ysc1a
    QfEzPxo+UShmBKfvBAeYL7mL/ly0k7rUuQA9NYRhRI9DrIKg5u7S2iy5Ol1QS/YB1LriAV
    pDkdCCQ4EIydR1wE3VepBQVTilewMoIgS7Mw92fCEZxgE8S+j8/6dFAg6KAlvQ4xBgmE5Y
    ss+JMUtuFxe7jCR5TGDyXdctY3CmEeqXDG93H4Zgq3F3bYc4m3Fs578oxChGVVLdPoFh4l
    vcvKYV0r41EclbSW/ze6/t/6ZPXTTZRcaSgKtY6YQJyzUESYMBjjPGLYkJuQ
X-ME-Proxy: <xmx:s9usar3XlzTwJYvA4tLyxwlgnxyImQOpIMPM2YQVPbmdaJn4SlDTVQ>
    <xmx:s9usaqgcYcxKC4e7Gz2SlWut33Qm0lrodPnGLWw0nSG43IMgRepqgw>
    <xmx:s9usarqT28ClioWv_VHdfJh_GXZqZGNfp8Ppqo50EzC6oE8nevl4eA>
    <xmx:s9usatPRQDbbgtNp_owbzUY42MSfghkc0eLXZD7d7Mojgxb1VDahew>
    <xmx:tdusah-IgVk6Nx-YSkRT3k0RKUprAHhUhFP2e8nozct_WPhDKqIOpP2z>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 1605332A0084; Fri, 18 Sep 2026 02:35:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AAZATSgDMLEZ
Date: Fri, 18 Sep 2026 08:34:58 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 "Masami Hiramatsu" <mhiramat@kernel.org>
Cc: "Christian Brauner" <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, kernel-dev@igalia.com,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 linux-alpha@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev,
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org
Message-Id: <6cd76fb4-0834-457c-8188-c68a507b6a6f@app.fastmail.com>
In-Reply-To: <20260917-tonyk-syscall_table-v7-3-f4cd8f8e3265@igalia.com>
References: <20260917-tonyk-syscall_table-v7-0-f4cd8f8e3265@igalia.com>
 <20260917-tonyk-syscall_table-v7-3-f4cd8f8e3265@igalia.com>
Subject: Re: [PATCH v7 03/13] scripts/syscall.tbl: Use the common table
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026, at 01:46, Andr=C3=A9 Almeida wrote:
> Remove some of the duplicated code by using the common syscall number
> table.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
>  arch/arm64/tools/syscall_32.tbl | 69 --------------------------------=
---------
>  scripts/Makefile.asm-headers    | 15 ++++-----
>  scripts/syscall.tbl             | 69 --------------------------------=
---------
>  3 files changed, 8 insertions(+), 145 deletions(-)

This somewhat desyncs the two copies of the arm32 table, which
isn't great.

> diff --git a/scripts/Makefile.asm-headers b/scripts/Makefile.asm-heade=
rs
> index f1c3d287c14b..b09dbc8992c3 100644
> --- a/scripts/Makefile.asm-headers
> +++ b/scripts/Makefile.asm-headers
> @@ -15,9 +15,10 @@ all:
>=20
>  src :=3D $(srctree)/$(subst /generated,,$(obj))
>=20
> -syscall_abis_32  +=3D common,32
> -syscall_abis_64  +=3D common,64
> +syscall_abis_32  +=3D clone3,common,32
> +syscall_abis_64  +=3D clone3,common,64

The clone3 variant is wrong on nios2 and openrisc, as they need the=20
__clone3 version. These currently redirect it using a macro from
syscall_table.c doing

#define sys_clone3 __sys_clone3

which will continue to work here, but I don't like how this is
inconsistent between the architectures. Let's use either
syscall_abis_* or a macro to pick the clone3 variant on
all architectures, but not both.

        Arnd
