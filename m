Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794207404;
	b=mgluqNK8a1or56IWGzL0NQDO8lS8cOWV6EIIBkF0y7bNleYYTBvLFZ9a5EFTCqaveZJ3
	 5iWg1+fpExWhCAYSlgGCNL06OBeHvl/7pCXNW3kl5fXTfTqPcyT0Okowx2bIVRATOYGAt
	 nbZsHPU8sds01NNpMKIko0+Rtkyuy0MHzcApMkSS6lGWfgYEL7D190e2Aig53X4x/IlM9
	 eTOafh0CgjVikZOaYW7g3IBCZvWWkkLX5FFYMwSh5vAakTZJJuKHdgGoffCBwSl++rqj0
	 mK+8DtUkqGo8j9TShoS+DNNIF5ZgrUco2GPy09889XjQ6UYDT9VHhn9CJIqRMLjOfpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794207404;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=WHqpquX4+WgSAOGsQ15QoNjicHp3909wIyVH3LC+fIc=;
	b=aLSLpQueeu04ZH4V7cb5/PWXJ+B5XPDxrVlvreSmc5p868VqNO3CuMqDUBVnuL7mkE/v
	 fuI3oeJ+QJMqvm8n7X26Ck06Ro1DLBF24KO2PWIBfCWVtjcoW/1kFFPCQaNIxF/j55Fup
	 29WfYa1fiyjbHofTLBJt2R7QM1ZsY4whEA3/WBpD5/ZxAWdrHf8AYWJwsea4wBluswSnV
	 iklBthz8M3sGP/OC3GUevqBCRjigsXVQYyXdk+zpuKcBa6U5qbqS0neYzidjOApbIyJSw
	 Zb2lhBmqdZMntbfHEDDFtIH96nxrhQ8Q5ZcdaGybyF1k5KxumITtcClmJ79YrsfwgVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=E3x4iL2G;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=E3x4iL2G;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9546606A321;
	Mon,  9 Nov 2026 06:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9546606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=E3x4iL2G;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=E3x4iL2G
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BFB4422086;
	Mon,  9 Nov 2026 06:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1794207401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WHqpquX4+WgSAOGsQ15QoNjicHp3909wIyVH3LC+fIc=;
	b=E3x4iL2Gc/XWuhfQMNUOKqoI4E0m5EnETfzT76nx6b7qV84ubOZiHQopTGE+/ShjT1Su+D
	eFv5cAYZs/EKOrf7+MUOKlm7pcH0yOnhLuDMf/po4pG9Tpzh6WvMHKJmfxAcqdpc47p7ju
	WNc+k70F0GbHtGFIh5lz5AnF8HMqzw0=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1794207401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WHqpquX4+WgSAOGsQ15QoNjicHp3909wIyVH3LC+fIc=;
	b=E3x4iL2Gc/XWuhfQMNUOKqoI4E0m5EnETfzT76nx6b7qV84ubOZiHQopTGE+/ShjT1Su+D
	eFv5cAYZs/EKOrf7+MUOKlm7pcH0yOnhLuDMf/po4pG9Tpzh6WvMHKJmfxAcqdpc47p7ju
	WNc+k70F0GbHtGFIh5lz5AnF8HMqzw0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A17313302;
	Mon,  9 Nov 2026 06:56:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rXt7D6hu8WpCCwAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 09 Nov 2026 06:56:40 +0000
Message-ID: <b8d171de-52fe-474e-96db-d119840c6240@suse.com>
Date: Mon, 9 Nov 2026 07:56:39 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/9] xen/sys-hypervisor: Add release callback to
 hyp_sysfs_kobj_type
To: Ian Rogers <irogers@google.com>, Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook
 <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>,
 Srish Srinivasan <ssrish@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
 Alexander Aring <aahringo@redhat.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Zhihao Cheng <chengzhihao1@huawei.com>,
 Sumanth Korikkar <sumanthk@linux.ibm.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev,
 llvm@lists.linux.dev, linux-hardening@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 linux-s390@vger.kernel.org, gfs2@lists.linux.dev,
 xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261108223913.3624571-1-irogers@google.com>
 <20261108223913.3624571-7-irogers@google.com>
Content-Language: en-US
From: Juergen Gross <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <20261108223913.3624571-7-irogers@google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------AIXzU7yBxxMCFwv4ehArOVmL"
X-Spamd-Result: default: False [-14.46 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_SPAM_LONG(2.83)[0.809];
	SIGNED_PGP(-2.00)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_BASE64_TEXT(0.10)[];
	XM_UA_NO_VERSION(0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[45];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,users.sourceforge.jp,libc.org,physik.fu-berlin.de,epam.com,google.com,linaro.org,oss.qualcomm.com,redhat.com,amd.com,huawei.com,lists.linux.dev,vger.kernel.org,lists.ozlabs.org,lists.xenproject.org,lists.infradead.org,lists.freedesktop.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLujoqb9xj6u63c55fak3nsx3a)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -14.46
X-Spam-Level: 
X-Spam-Flag: NO

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------AIXzU7yBxxMCFwv4ehArOVmL
Content-Type: multipart/mixed; boundary="------------vYCWG004ZOIZfxgQWDErlryz";
 protected-headers="v1"; hp="clear"
Message-ID: <b8d171de-52fe-474e-96db-d119840c6240@suse.com>
Date: Mon, 9 Nov 2026 07:56:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/9] xen/sys-hypervisor: Add release callback to
 hyp_sysfs_kobj_type
To: Ian Rogers <irogers@google.com>, Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook
 <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>,
 Srish Srinivasan <ssrish@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
 Alexander Aring <aahringo@redhat.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Zhihao Cheng <chengzhihao1@huawei.com>,
 Sumanth Korikkar <sumanthk@linux.ibm.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev,
 llvm@lists.linux.dev, linux-hardening@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 linux-s390@vger.kernel.org, gfs2@lists.linux.dev,
 xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261108223913.3624571-1-irogers@google.com>
 <20261108223913.3624571-7-irogers@google.com>
Content-Language: en-US
From: Juergen Gross <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <20261108223913.3624571-7-irogers@google.com>

--------------vYCWG004ZOIZfxgQWDErlryz
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDguMTEuMjYgMjM6MzksIElhbiBSb2dlcnMgd3JvdGU6DQo+IGh5cGVydmlzb3JfaW5p
dCgpIGluIGRyaXZlcnMvYmFzZS9oeXBlcnZpc29yLmMgY3JlYXRlcyBoeXBlcnZpc29yX2tv
YmoNCj4gd2l0aCBrb2JqZWN0X2NyZWF0ZV9hbmRfYWRkKCkgKHdoaWNoIGFsbG9jYXRlcyBh
IGR5bmFtaWMga29iamVjdCB1c2luZw0KPiBkeW5hbWljX2tvYmpfa3R5cGUpLCBhbmQgaHlw
ZXJ2aXNvcl9zdWJzeXNfaW5pdCgpIGluDQo+IGRyaXZlcnMveGVuL3N5cy1oeXBlcnZpc29y
LmMgdGhlbiBvdmVyd3JpdGVzIGh5cGVydmlzb3Jfa29iai0+a3R5cGUgd2l0aA0KPiAmaHlw
X3N5c2ZzX2tvYmpfdHlwZSwgd2hpY2ggaGFkIG5vIC5yZWxlYXNlIGNhbGxiYWNrLg0KPiAN
Cj4gQWRkIGh5cF9zeXNmc19yZWxlYXNlKCkgY2FsbGluZyBrZnJlZShrb2JqKSB0byBwcmVz
ZXJ2ZSB0aGUgZHluYW1pYw0KPiBrb2JqZWN0IHJlbGVhc2UgYmVoYXZpb3IuDQo+IA0KPiBG
aXhlczogY2ZmN2U4MWIzZGQ3ICgieGVuOiBhZGQgL3N5cy9oeXBlcnZpc29yIHN1cHBvcnQi
KQ0KPiBTaWduZWQtb2ZmLWJ5OiBJYW4gUm9nZXJzIDxpcm9nZXJzQGdvb2dsZS5jb20+DQo+
IC0tLQ0KPiAgIGRyaXZlcnMveGVuL3N5cy1oeXBlcnZpc29yLmMgfCA2ICsrKysrKw0KPiAg
IDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3hlbi9zeXMtaHlwZXJ2aXNvci5jIGIvZHJpdmVycy94ZW4vc3lzLWh5cGVydmlz
b3IuYw0KPiBpbmRleCA5MTkyMzI0MmE1YWUuLjBlOGEyY2Q2OWZkNiAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy94ZW4vc3lzLWh5cGVydmlzb3IuYw0KPiArKysgYi9kcml2ZXJzL3hlbi9z
eXMtaHlwZXJ2aXNvci5jDQo+IEBAIC02NTksNyArNjU5LDEzIEBAIHN0YXRpYyBjb25zdCBz
dHJ1Y3Qgc3lzZnNfb3BzIGh5cF9zeXNmc19vcHMgPSB7DQo+ICAgCS5zdG9yZSA9IGh5cF9z
eXNmc19zdG9yZSwNCj4gICB9Ow0KPiAgIA0KPiArc3RhdGljIHZvaWQgaHlwX3N5c2ZzX3Jl
bGVhc2Uoc3RydWN0IGtvYmplY3QgKmtvYmopDQo+ICt7DQo+ICsJa2ZyZWUoa29iaik7DQo+
ICt9DQo+ICsNCj4gICBzdGF0aWMgY29uc3Qgc3RydWN0IGtvYmpfdHlwZSBoeXBfc3lzZnNf
a29ial90eXBlID0gew0KPiArCS5yZWxlYXNlID0gaHlwX3N5c2ZzX3JlbGVhc2UsDQo+ICAg
CS5zeXNmc19vcHMgPSAmaHlwX3N5c2ZzX29wcywNCj4gICB9Ow0KPiAgIA0KDQpXb3VsZG4n
dCBpdCBtYWtlIHNlbnNlIHRvIGhhdmUgYSBjb21tb24gZnVuY3Rpb24gZm9yIGp1c3Qga2Zy
ZWUoa29iaik/DQoNCkluIHlvdXIgc2VyaWVzIHRoZXJlIGFyZSAzIGluc3RhbmNlcyBvZiAu
cmVsZWFzZSBqdXN0IGRvaW5nIGtmcmVlKGtvYmopLg0KDQpJbiBjYXNlIHRoaXMgaXMgbm90
IHdhbnRlZCBvciB3aXRoIHVzaW5nIHRoZSBzdWdnZXN0ZWQgY29tbW9uIC5yZWxlYXNlDQpo
ZWxwZXIgeW91IGNhbiBhZGQgbXkNCg0KUmV2aWV3ZWQtYnk6IEp1ZXJnZW4gR3Jvc3MgPGpn
cm9zc0BzdXNlLmNvbT4NCg0KDQpKdWVyZ2VuDQo=

--------------vYCWG004ZOIZfxgQWDErlryz--

--------------AIXzU7yBxxMCFwv4ehArOVmL
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmrxbqcFAwAAAAAACgkQsN6d1ii/Ey8b
bwf/ZTFiD1KHpnwASdlC96fzY8LKDEU4SduJ4BSPmrFxqeUdpBJRlpL6PFjpCmtNPiLLEbLKSAKO
8V/XKxTIYctU0kiaUun1NZqGKFmrXr5+bd8Ni+xwtaGtIIfnOjqGyMzuwNciofyiVdRpGNDU4Ad5
+IpYk4FwGyKy7gkE9Nf03vXcbchktM8Z7Q9NrRvjll64xw9gneGYxkexvVMA5kT1E2odD6BcYrLI
CEO328qO8Lgz6SE8FgqgIswYgSDv+ZebyiTUHev2cTSA8n0v3O9snk/5y+Fsz9khYihMtTqVE/bo
tXZZc3GHoOhrkCuVNC/6dPI9Z74/ZIX87YIjnwMrxg==
=E5Nf
-----END PGP SIGNATURE-----

--------------AIXzU7yBxxMCFwv4ehArOVmL--
