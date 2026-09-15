Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C5B383987
	for <linux-s390@vger.kernel.org>; Tue, 15 Sep 2026 19:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789501661; cv=pass; b=IrEXoYo6SgV53Ok5f/jozVw/L9F2ZzkeymMfSDpxbjXZ/1BS9sYlVW5nK/ngQiWVGClDFlxzR2Ym7h6+eFrl/VLOH4F8NSNcIPNW0+XsLbvVfiIIAXBhV+ILAYh6KT0NaQXE6YQXfimJ+zTMYlhsO9AKflmyG48wfQZpIeSI7Oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789501661; c=relaxed/simple;
	bh=XPQeBwzJVFS7E7eRmzzs+WdXKCVvNPBVqu7jyYbAFec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qsyVNnT8pLT9dxGFUZ+q/Bf+e5IJkuLm4sjRbcDVmKYtVfA1croAcY9Oa44GJRheXUYmK5Brsqc6DnW7y5iywqSBq9xjVjc/GaHgAhwOiTYPW2PZvOboEdWVCRW/D7A/NnQHlxADG9Cv+q8uoxJfUPrMNDvUHarl8Du0XlcDEcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hBba8wHN; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hBba8wHN"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530d5fc2cd8so63021cf.1
        for <linux-s390@vger.kernel.org>; Tue, 15 Sep 2026 12:47:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789501658; cv=none;
        d=google.com; s=arc-20260327;
        b=Auokl3xUd/oI+hYw+07AdS2v2mDnMtA7H9uRWuzqU7oxOvJ8sYqc/WiVcbHbMJblLf
         wllLVtbVjQK9XhMqpzCcsxfL02zoCRj1TZTsDlztr7/OJnsdx/dt40kkvGEEb/bjw9V9
         7cbHZl3o3WyUu9IpAk991N+VyErti/noJKz1jr/fljn4YaUUHDAeM6+bbgwo+cOJAJOr
         UEwNTDuNEJFdROwWTsXoac7ghKpoLWzSWcrIGFHs3B7pCZ/8meY9g8LEOgLXb0JGjYoH
         vAtOtirz7FZMx1SQMh6e/9ncXmfkAiZ0C5ztONMUZiNMwoqcUCNvCRkDcJBTwfHHT/jV
         VN8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=85J+aiA04EY/KMG60rW4VZXcI33pWG+C3OlEjBwYKSc=;
        fh=zhCvK9cLi9J7hE2H3Ce8+HcrtpEbiK1dLQl6jcZf8so=;
        b=pQfl3tBFyeEN0eWOSbKObv865WRVzen3z/0HRSWEWO4R9QFbkWjXQCRf0Wvz0WiFmV
         2BePnTxEa7X0LqUj7knrZx2d6UOqFC7+RxuBeLypfXAK0LsnUg8laV0bMhbgVKY/SEWW
         DFMZ/XSLfJHaeQujSyHX+ykFN3XD2Gd683DxYLV7Be+c4qmdFqsoVZBbx5qCheq+1Dlx
         ALNyHhARYgR3O9ASVDFozBZPRRM7Npgibj25L3TpCrXzQPYn+hRbdeLJgZSXWuSrpYdA
         jxO+pqDi8nC9uayT3COLRntZLMw7TXIXsi6JK9OostGiZtoVNbu1vjFWj8AQljTtzG+3
         9kLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789501658; x=1790106458; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=85J+aiA04EY/KMG60rW4VZXcI33pWG+C3OlEjBwYKSc=;
        b=hBba8wHNjK8wmNIhIRnK3enamrCwSDZSeFUUC0HJpxzMEoggb6yUH+s0mOusUaoStM
         iecVpu8mFiIPXIQU2zT2wRPJKsxcguvD6Xh48o1Kltwo772OwSLDBky5aLfLy9QDh0lz
         8oh2ej8ojvahLjh9aBcqNr0DUtIMgJLcg4sR/k9XWnFXb9CYITT7mLpXCYSsIFWS4QdD
         LSwwJJguqFvZpgCDe1n3fD1dc62A1Xgpq8wmLGR5qGY1lL6fpQgcSb+Jt3HaVb94JCvz
         vCc4C0abu/n6KL07QyQpXKZ1bKfv3dKyzzr619N4rGK3d0WJ3n1G+ax3NFj9uv4rT/Oi
         1OGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789501658; x=1790106458;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=85J+aiA04EY/KMG60rW4VZXcI33pWG+C3OlEjBwYKSc=;
        b=WGi9g+/4TLNkEoM0WgYCKNHFCRGcHsEKxgVyAEE/fELiJ9LSa5EExqDV/8yR/g1dA0
         9n4KU9a/zCnwDuHoisHzIzYWGq3nfZEjatsx5t8d5hk6Mdga2B//CT3FNKGDFN9/iddB
         ndEFDY6eanZTxng8JHsKtZ6UgvTUtks8/JfmP3119NNeIjgkiS14K7GMDb2lPq8H+mCd
         UyVmCAM5H6B40yg5kTiIdSwZFJ9KMXcfDAzTpOi0ynCzEGMVtAsusV0Nj6Zn3Cn9APxQ
         kDIrjExlmVGqcjA82gasrPI8vLVJcOAkhI+KUJ1TDDnrUe8DozpvDLfoSmGg307qpmQR
         TktA==
X-Forwarded-Encrypted: i=1; AKwUvBxqAM52OJu2xxSXgAlyZ9OepvjWS0NX/ij4Fb0cJTkpJKtIcl4R7doAXvhNl15FjbIZtZILFzzXTntW@vger.kernel.org
X-Gm-Message-State: AFuF++mXqCSQ/0eKhX8Q31NQFqiTr/GVGhDKzCdY4Xx3GO9WV3V6L4MJ
	glYSXW2VErUJ2lxAW7TdY57Whq/RYQYQ4AXFVrqktQbEuN3SCLym96BWlZW6/fwfbthXDLRel6g
	IBBJTtK+weeXLdJ79IFRWjYgfYm1DYQ8beetGkbYj
X-Gm-Gg: AYBFou1esqUO2VWkWO8kW+sbHuNegL0B1XonqjA/FFFG8E9lPvQ/8TWdgj4WdFlZf5F
	pE9u1JZR7k9je4E/76yi6S1J/8RAYw0g7xh+Ygx6UTuUvzhIEZlnjSc/O4ZHmbC9azTJIuvdUk8
	ivbtv0/adlojta5jejZ6ZEuXONqfMuHNHK9BzcaUoQufMCI6SVHMJx4k77akQSJ6pj0cubwVzAM
	jROskItwxx4NZ1NJ3V1jp/ojImsRMbmpmajhLMwv7P+t0pmHsdGB/oD8IK86YIXQM6eesqOTk7r
	ag6eyuTyDME7GoigS0Vvftqzve8LiCVyO1a84jZjoy0wAq1lX7ClR6DnlzYH6f0TL2V+Oxq7ZQP
	n1Z5EsGPo4hg=
X-Received: by 2002:a05:622a:11c5:b0:531:129b:2dba with SMTP id
 d75a77b69052e-53259a9396dmr2409481cf.3.1789501657735; Tue, 15 Sep 2026
 12:47:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821125538.3721169-1-jremus@linux.ibm.com> <ba75c436-ae41-4754-8a73-80e2e5df76e7@linux.ibm.com>
In-Reply-To: <ba75c436-ae41-4754-8a73-80e2e5df76e7@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 15 Sep 2026 12:47:25 -0700
X-Gm-Features: AcwNN1XUo01KXBIUBoyjPH1IxD3wuQZzmLQBC8pBcdAs-LnVLvB7_CmYe-5vPlQ
Message-ID: <CAP-5=fXGKJk6VrWTcdC8iUdhzw6djscJ8SBoJiBgFaPH8TWSZw@mail.gmail.com>
Subject: Re: [PATCH v2] perf evsel: Improve callchain warning for s390
To: Jens Remus <jremus@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>
Cc: Jan Polensky <japo@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 6:03=E2=80=AFAM Jens Remus <jremus@linux.ibm.com> w=
rote:
>
> On 8/21/2026 2:55 PM, Jens Remus wrote:
>
> > Instead, warn on s390 when callchain sampling is requested with an even=
t
> > provided by the CPUMSF hardware PMU, because that combination is not
> > supported.
>
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>
> > @@ -1078,9 +1078,8 @@ static void __evsel__config_callchain(struct evse=
l *evsel, const struct record_o
> >       bool function =3D evsel__is_function_event(evsel);
> >       struct perf_event_attr *attr =3D &evsel->core.attr;
> >
> > -     if (EM_HOST =3D=3D EM_S390 && param->record_mode =3D=3D CALLCHAIN=
_FP) {
> > -             pr_warning_once(
> > -                     "Framepointer unwinding lacks kernel support. Use=
 '--call-graph dwarf'\n");
> > +     if (EM_HOST =3D=3D EM_S390 && evsel->pmu && !perf_pmu__is_softwar=
e(evsel->pmu)) {
> > +             pr_warning_once("Cannot use hardware CPUMSF event with -g=
 and --call-graph.\n");
>
> Jan, Thomas, could you please do me a favor and test whether this works
> as expected on LPAR with CPUMSF?  Time was running out before I leave on
> vacation.

Thomas, the change looks good to me. What are your thoughts?

Thanks,
Ian

> >       }
> >
> >       evsel__set_sample_bit(evsel, CALLCHAIN);
> Thanks and regards,
> Jens
> --
> Jens Remus
> Linux on Z Development (D3303)
> jremus@de.ibm.com / jremus@linux.ibm.com
>
> IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsra=
ts: Wolfgang Wendt; Gesch=C3=A4ftsf=C3=BChrung: David Faller; Sitz der Gese=
llschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
> IBM Data Privacy Statement: https://www.ibm.com/privacy/
>
