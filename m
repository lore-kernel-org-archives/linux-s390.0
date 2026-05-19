Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908CD37D10F
	for <linux-s390@vger.kernel.org>; Tue, 19 May 2026 06:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779172719; cv=pass; b=emxZ0GbUK+iq68Yx2VKDCxaVW9DqxPhpUFZjdBjc8DdAPyySqbdQghap5JDSun0yOIJtNRXge21KhLcZaC8hxAVIFqlEMVe7AP9vo5tAHZ7pkt0WWgDZt9hvcLIIjr7WHOrlKpjw62D10uNRuQgQQo9jgnatlFU8T9xDZbr9dFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779172719; c=relaxed/simple;
	bh=0qcoTORhor/gDYJY7Q0+ZtSf5jR9sEJQ1TRR34MkASk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bbb4zxsibBooA19Ta7IrW68em+9LeyFMuv7Aa6Gq28lcPoSKPkrH88DXMp8Hnd8AHYA5WysQ2RwH3zpU5T5wuiU7NiMTWKgQn32llEm2KIXTxGD4E8drfvYb+nI+XkxyWzWTdplhcfZ494/11BWV6Gdsrs4DrsXdfblX3Gh/oZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SfdmOpDK; arc=pass smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfdmOpDK"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2ee34d7e55aso302494eec.0
        for <linux-s390@vger.kernel.org>; Mon, 18 May 2026 23:38:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779172718; cv=none;
        d=google.com; s=arc-20240605;
        b=gwf9HvPyqPKvFja1KzdNGjXZwLu8X+zC1qLfDSubVztgiTnMqZpwh6GkJmljtCM6V6
         LpVTs1ynAoH2vN9B8wvLwgJ4b2qZWDIgnw7zOt9EOgu3tNbsJ7OU/iMSdIs9JbggljPK
         uImDaQ1q/O45rC2k/3dga1/pF/OXFTVRSQ6cge0T8rYsnoP//fy73ym9hwRpV2N/RtXl
         YZxdqPWDljd6gPXhpQ8IrwzsIkQ3zpknekbeSUhzjFYc24Y99OXyUDH3TO1u4mBg321G
         x87zFnCYtOn+r0e7rhx21H/se56walN5JU1LYdGwbj5gw60i2IK+vlccKRNX6JN3jObY
         moDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0qcoTORhor/gDYJY7Q0+ZtSf5jR9sEJQ1TRR34MkASk=;
        fh=G5di+UVou29uMCGXnEpA8pQXN2ruM3JTaZi0kxhsxMQ=;
        b=hLOSEmJlfkBt9U4YDGdhKzrw/W+f5RIMRx7bS/pnkYmzw1hCIG64lLyiBsPUFLyRwm
         gYAwo43TTU7JruaPXd1bHOX5jShaVBsp6+q8JA/lb2Yvsb5PaVCKmWaa0VXTmjZJi1F0
         MCHJ7YKd/uSctrhdkS5rc6TP08FLjJUBbaXT5+HRgOJVA135VUcf8rilB8SP0z00zKD2
         4eSBHjqrn5M0F+DzQ4ntzK00fxPeTj5D0SBZKGfZMbFqiKeYvh4jlSr7Quw2xAIdYXZi
         NwdrqVmwTnaO4X1UWKA/aOV2vKuggOqGF1F9i/APsVuzO31n4UJUVKwwFIMkpHr4Tix0
         h/qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779172718; x=1779777518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qcoTORhor/gDYJY7Q0+ZtSf5jR9sEJQ1TRR34MkASk=;
        b=SfdmOpDKyqmVT8VqeeoJU3P4FWC2QCsSxNyxnM3faXyyIhRWXqF3CFtlzuoHL42I83
         U9QHaz4cb6Rs7zpqdJsLdbvG9hbrv8X7k2ehsf/Y6PjNwHDpz4HlF0xZOCNMIUXNQNRd
         qJ7/3HzJBKNYRa1odCtYGqgJwRKeOAYGkiLHxLZ60UAtxT7dG66dSD6BfqK7wTLz7s8h
         6d9I3nt3BWUp+3fsw1AGvFev/13JXDR4Lwek7Pv2ToTpvMerQUrYGY1YiPRKwcTTVErj
         NgJli3pi3WxXDHEK0f30INYfyfJm43+iqYwuTdIEq9/kf/XXtNWKadEv29SyMOeVTHEs
         pivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779172718; x=1779777518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0qcoTORhor/gDYJY7Q0+ZtSf5jR9sEJQ1TRR34MkASk=;
        b=oLnZ6uuEzb8zKfUcw+UCtWdXmaqfOFD56u5bo76EvJPcDggrpLy7hej53jOm4eMoIP
         Kv2W9Erus7XioypEGKw/ui6ZIHj92I5z7F26fZjYI+3/OmaMP2yc7JMSPruFkduvwqUg
         xLn57/9TKIrir1WcboFlUzEoqnBcXWG94plZzA+OsDOk4tvBzNaZgHyPgMpge9PcrNap
         BDbORHqYhWZ4le0EN4DlIB7A7InMTueAS/inl1AawOs/JIqI0PcLj2wlMnlHn/QdHyAD
         kthELk6uzLhKWYlMrjAAp+0CEsFEXKNy1nR/N5Vds0keE+IQfJSVRhwjPcqQQJqXhox7
         q1gA==
X-Forwarded-Encrypted: i=1; AFNElJ/YbFIz+1faL4BQj2tB5B1ccG1ILjUmvpPg9E6s5JCA1U/QV9pts1sR9NQtqUpjfWxIOh+RomFMWSsx@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9IA1xzP7oHzSOkBUKJFYpQyUITg7qB6sMXdtA4NUxjj9Cq7OC
	IWWLni6aLQ7kEoJTtxtRAzHJpJGtg9DPJi29n3HS9W1+HQJ2/eVR0sWICesJA0f2nysKC5l8gWq
	i+BbtwJNNCdx2UihP0feP+ToU4N1gS24=
X-Gm-Gg: Acq92OFSLzeoxN/muR5pGvyVrzQJqzcaGNGVtkO2RmYZWpkd8/miOmz6xZoJD/7+5r4
	pwIM/nQuHSUHrh+MyQxpztdN1EUQqY8VFmO/JYNvINI/d2filfXeI9HLLFY3JDBlYtKoLNDRgUD
	HQLxyoZ8uWr8PvaoX23TwXHyZ/twahdHmV4chxe81W8RgpneHxQSQudD3dD4kLq4OllmWAkS4m+
	6GTO8YJouxU42397oMVE7dFyt7SNTusWNhIEyOH+1E2uhbir8A3w45+1Cs9xAXllEwZuG5Znyc9
	+cB88MNeeyZ7gWJor9BycNtND35hsvC2y+XUQqgwtMRN6YMfeRRt9QTZ1OwZlFlEnOJDrjLhJ8K
	JnJo7I/6mygFSbIrQLBdYVj0=
X-Received: by 2002:a05:7300:dc03:b0:2be:298c:a11 with SMTP id
 5a478bee46e88-303986626eamr3489121eec.3.1779172717585; Mon, 18 May 2026
 23:38:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512105920.2426293-1-japo@linux.ibm.com> <20260512105920.2426293-5-japo@linux.ibm.com>
 <CANiq72=dD5fw6XmLJ=zSq_k_ZQy8sLLMs3m1xjX=UTpO7tLisw@mail.gmail.com>
 <agst-5rhj2mFF448@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
 <CANiq72m0n4M=Yyb2=Hhrpg3EWk2-a2Q8V0Fc=0Ss50HuBO5hHw@mail.gmail.com> <agtnBewXZw83JhPQ@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
In-Reply-To: <agtnBewXZw83JhPQ@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 19 May 2026 08:38:23 +0200
X-Gm-Features: AVHnY4Ijo10OsLN6xtMCcuTqUYVDermo_oJ9SPMnGbScXPYCPWVI_GRQeGnWld4
Message-ID: <CANiq72kP42ONsFZH94ch34x8-n3MXJOPvW3XvFZV2=_AX-HOew@mail.gmail.com>
Subject: Re: [PATCH 4/4] s390: enable Rust support
To: Jan Polensky <japo@linux.ibm.com>
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	ojeda@kernel.org, peterz@infradead.org, jpoimboe@kernel.org, 
	jbaron@akamai.com, aliceryhl@google.com, borntraeger@linux.ibm.com, 
	svens@linux.ibm.com, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, dakr@kernel.org, rostedt@goodmis.org, ardb@kernel.org, 
	linux-s390@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 9:22=E2=80=AFPM Jan Polensky <japo@linux.ibm.com> w=
rote:
>
> Thanks again for creating the tracking issue for -Zpacked-stack and for
> all the references, they were very helpful.
>
> Regarding the toolchain: since this works with the Rust-for-Linux
> bootstrap mechanism, I tested with rustc 1.96.0-beta.7 (6be5f81e1
> 2026-05-17) and everything behaves as expected. I=E2=80=99ll update v2
> accordingly (min-tool 1.96.0 without the -nightly suffix, and adjust the
> wording so it doesn=E2=80=99t imply nightly-only).

You're welcome, and thanks a lot for testing the beta -- it is good to
know it works!

Cheers,
Miguel
