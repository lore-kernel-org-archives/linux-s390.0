Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFED225413
	for <linux-s390@vger.kernel.org>; Wed, 27 May 2026 08:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779870472; cv=pass; b=qIr7Y+ilNpHGGoUftl+Apko6A8jR8zRBRxU+SeBXXAtAsJJTdMEneeyRW6wCccfQzQgdBp2+/8eC76+HZMsEQg2xkabh58F0T3iNOZmOEUvE07g5wUxYAn1GIdgFww338n8hyKWm0ggDFY6knlW1Ps2kZLj+Pq8ZKjiKRW4SXuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779870472; c=relaxed/simple;
	bh=7xt44RJJnzqn5R1ogr2LUx2SaP/KU4n4N6j/0zqdtgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PJcUEzisH+4DPLCwwvaJzFwTe0X0kVFT/5Uuqjo4ZTG0TEbmRh0i/P+/zjjWhTkfVwYCEkAsecyFFECr4CKX6wx48HLfem3dMMfaRJYOh5jSQpgwcIVUOtssI1XfWFOXt0spwamnVJxxyWKtRdNs76jWXLMv3B7EHov3B0UBuWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJH1J3vM; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJH1J3vM"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3042a99f0ceso579839eec.0
        for <linux-s390@vger.kernel.org>; Wed, 27 May 2026 01:27:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779870470; cv=none;
        d=google.com; s=arc-20240605;
        b=MucWgcp3Fv4/t0OfkHHXPGc7k9ewM7xtRL/x5gdHRM6ijAVCVc5rQNMNDycxg/LEIh
         6NefJw08sudyfwc5sqXkHGDYgz37X4QCL5+msNDuhUupWfVclRdb8zWypNqf7r4po4RV
         FWZ70vaFKKgaSTrDXhY2l0Wi8x63qfxyvuY1YYRKBps8OO6HxV+kCkKLih2ecXe35DHy
         LwbuIdbUB+i41nLoDgRII2lb9gT7cO5oiesFU2/NmpH/j/lf9UW7ft0kqBzqPbEoG+fz
         BfsUMQihHgZiZBjwrX2ub+cRb3XhmEOPqIxSp2AH3unIz62O5TU255W+oxoRFSuQe0nA
         4UEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7xt44RJJnzqn5R1ogr2LUx2SaP/KU4n4N6j/0zqdtgg=;
        fh=JxJrnD8xhlHB7CmqcC2IoLnEeuBSLCAcJsDuJaSVTOo=;
        b=QnlcHLp5IyKgEsj/E12VPm47t4Oj4WCRUURdvM0yqu5XQ8+x6riNkpkovcgtRRMsUU
         2o8gv1eZcUxE1hRYTgjCgw1+wbQlV564c3HtjiD9dCv2dI2XO4zkacotmXKRAd8ZQFzQ
         tuuSIpp7vEtT8eBp11849ySeAULhGohfriA/2C9cxx2Q5HOaNqGnFJRkKFLh5wfBmf4b
         EOgLsUfRg3SkPSsRQ4TaceQ2ovRwTExyG+nabFGHWAKoXrcvrCjyahuR55D+tk44RWh4
         yC7yIwmn3e+I6m7SL1hVFuYSE22/6r6tCFepm797hk2nVsDdyfzhecmMDhJ884ZZBYKX
         wblQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779870470; x=1780475270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xt44RJJnzqn5R1ogr2LUx2SaP/KU4n4N6j/0zqdtgg=;
        b=WJH1J3vM0iYFIcHYEEi4N9nPFqJajK8a0Yfv/emXy7n/lAnDP7nSCxZXoZbvow+J9n
         1pGgzrVjlSw4BqW4DuSzgiXDkWAJOn4BUKCBtHTq1npltrWq7OQapzVMSGvhhT3M5hvW
         yvemxQNcAFEsD7WZLlI2Ljjeffpy3WuV4hPiGU2w06hyw/4dwNUorkbDWVNCaTkHaRVe
         UgVaI5/PDHznnsr4p06vYNVpu9no1vYyEnOjydKPauZX7RFCipjIxcOgzHuNZq9upjpq
         qb+3CGpHzShcuRW7z55z1e8ksTm/G2QQ8Jm/sqFHuYe0f3LlO0Ce1Dy3EJOvhxKHs7QU
         GjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779870470; x=1780475270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7xt44RJJnzqn5R1ogr2LUx2SaP/KU4n4N6j/0zqdtgg=;
        b=J42eejj+43WpZd7njtyvmtczrgd2XXCwceXBDgZXwqzkCcgmF9sw6nKxgjrtyEw9U3
         Intlyr6kLfsuO4vIpiPFZeYB+PFYWxIIoo4ndxJmvKi4Wh1Mdi+F+J1kLv8ZXK4EhcjL
         xNtRXKT3wXgNTD+Pgc+C5IQV1ToV99nt6U0Ccz16cyAmXDo1ErtvECclhdXbUW/tOTtO
         mDcVR5D/h1BulPScUgqA3FHFRgt6KAuyDTPhTmlMv+p6MIWr1dJFcddmXDNwEGNWBEM1
         RaCEXH/yuAzXKIAFQZiP33Xpwgb6FXjT9a3HDVDeUogZD41E+7LmEGGOQ7V+1RysLbfE
         1U1A==
X-Forwarded-Encrypted: i=1; AFNElJ+Kt26gGfNb+LL6rBc9ftxet/jvtB/1pUEC4TP5MhInLf15A+/lnhw8dwBnpFPQwQkWCQub7kUrKFc6@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxml8hyB9v7tUoQtPNb5ZF+2YX1+QxI0Fwf1NR/HKJU7zpKQxn
	HyWeaYy3BU56QFmlSdyK+7wwKsvxJrexpbhQfvRpedIYCKo//m9tz5fcN+9M3NqF6Xesx+UIOOj
	sh9AzC0KhmvMMjkWONJ7gow4LID4vdqA=
X-Gm-Gg: Acq92OFD2iN9EnLiPVKHrSMD6i65X0YWlyJ9mjfBUUod5nG8sX4ODSAYwY2kdoP+1pC
	/TDkOgCQp/06TRdwyEUxZhOi6zJeQQQjVLMuLnGbOp7SN/eP+EH4FBigPodi/a6ot5ebyKQJ/W+
	s62GtxuumtHNljDCYAuqSGuUgKgle4kyTYKnrPhfy5CYSwbrCK/9gf+mzsPklnroTgoIl4m3KWQ
	5RJlG5bS9ojrGI/9M1wefLDWmxLU4Lbm2lIULIio0Y1Kaa7J3aFZLuaY7yXGrVinJbQgB0QyYIb
	u6jOBsQUSt7D+3n3cVcizTED+IVxmGMS4zTPlWDCx+jeuPnocwELyxjtJ3Z+B8xJHF7wz86IAqE
	mRs2eIBfZ4FnDbfy9rgnk9aE=
X-Received: by 2002:a05:7300:fd10:b0:304:1fb6:8903 with SMTP id
 5a478bee46e88-3044911cc33mr4821140eec.7.1779870470501; Wed, 27 May 2026
 01:27:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521165622.279953-1-japo@linux.ibm.com> <20260521165622.279953-5-japo@linux.ibm.com>
 <ahaIT7BV-gMqcVh1@google.com> <20260527065302.9471Af6-hca@linux.ibm.com>
In-Reply-To: <20260527065302.9471Af6-hca@linux.ibm.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 27 May 2026 10:27:36 +0200
X-Gm-Features: AVHnY4IUg5QIMtvbexVfCzc49dur0UfniCtjW4qe7jZeoBlWqjjSUR3a6M3J8hc
Message-ID: <CANiq72kd3f4jhuko+2xemrjO_Vcpt6ifmBvKtb7qP9=eELZDxQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] s390: Enable Rust support
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Jan Polensky <japo@linux.ibm.com>, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, ojeda@kernel.org, peterz@infradead.org, 
	jpoimboe@kernel.org, jbaron@akamai.com, borntraeger@linux.ibm.com, 
	svens@linux.ibm.com, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, dakr@kernel.org, rostedt@goodmis.org, ardb@kernel.org, 
	linux-s390@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 8:53=E2=80=AFAM Heiko Carstens <hca@linux.ibm.com> =
wrote:
>
> On Wed, May 27, 2026 at 05:59:43AM +0000, Alice Ryhl wrote:
> >
> > For other version constraints we have listed them in the Kconfig file t=
o
> > guard the select HAVE_RUST or similar annotations instead of here. Is
> > this the best place to add this constraint?
>
> This is supposed to be the default location for such constraints.
>
> See also the current limitiations for gcc and llvm in the same file, or t=
he
> previous limitations of llvm for x86 and s390, which have been removed wi=
th
> commit 20c098928356 ("kbuild: Bump minimum version of LLVM for building t=
he
> kernel to 15.0.0").

Yeah, if it can be done in that file (i.e. if it doesn't require the
kernel configuration otherwise), then it is best to keep it there.

Cheers,
Miguel
