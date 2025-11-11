Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C654330B1F
	for <linux-s390@vger.kernel.org>; Tue, 11 Nov 2025 14:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762872256; cv=none; b=J5U7hi0L0Q1Fk8MgTOKwSX713cvtusk8Rg3k3qUi0y5/KYWhEp2RBVWIt34A6OlS+D9CyCac7/XlHvML3iKNxnjDJJ5alLP7h7toeGDIafOSejhDxIUW4frOMnpbKbVM8PQ5+yq82PKq4wU7tgf06tddVtE86Z5ReyKqzj3uMyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762872256; c=relaxed/simple;
	bh=lwgS3XbuNGNElPjrkWO6JmcdiBkj45I6XbH04gS8S9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PpKtmpWmhNqztJfo/uFFmVubl6FaB1BUwyZKJ4PErvbLrK2eL7J3aJ69+7RB3szzOmzFixn/RKdmkf/XUIQjT49ZqyMyb+8Ow2RxSHacYUJTBhJnK0GN03eIUtuvhIRFD9h0adv8Vgx8URUYCeJUgX5wXUKCKn8yj9Yd5QIXNDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B26i8EVw; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B26i8EVw"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-640a3317b89so6308667a12.0
        for <linux-s390@vger.kernel.org>; Tue, 11 Nov 2025 06:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762872251; x=1763477051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1/P4cjnJRMKeJXb4QuiXEQkEuLjYJ7u3PWbuQSeBbc=;
        b=B26i8EVwNr0OD0zHqdEkjjpOuUUrxB59VdgnsbdKKbkIZgwuyOASDOmOXnd2K8wtI3
         TR66+bwWeU3e4pgHzj/mxM2Q8bNfvE7FqtzWIiLew0GRLtXfxv8ZPjQKkIoKQousTYtB
         m9Y5QSUUi0mpaQOmNE+dLnITjVcwIgL8fcdHcwAdJaVbxcX0WndbvAmXlv5/t4Gi3qAn
         Ghu9Ybbz8F5RP/7EsY5555Jwh3xxk4/lx1CaeR/nZfbmWgiETaYBQCHm9iLv6yoHi8CZ
         4gcsdQiI3D+EaP9LkQ5qkEwRC7bPOfawNJok+rPsJylwpLIRD/BULbBBvvYIga/6Hq2t
         DdPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762872251; x=1763477051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y1/P4cjnJRMKeJXb4QuiXEQkEuLjYJ7u3PWbuQSeBbc=;
        b=kD2oVrSV318lRkvLM6ETgQENTlHos7Zzmx5gNQGo+Xg4wrYetXm0ShrTvMeJkI2rcy
         pGmEY96J988ILh1QJ60dlcNk4h9psiYsMSgsg6W4ObHdn9HclrYwNo5b2bjoNZhDJku9
         vBmGImWGT9iUxGbfW6PatMX72hVBV9QXt2t/rnf0OaMBUm5u3sd1iEqwvqQD+loqNNwf
         ykfEf53W4s1M4y8UdZLyD/l0AcR3AgGGJFAeo0k++un1sZ96kDKZd9mPVdD43cF7r2r5
         tlt2lZMfsYxOU64ZVE3CpCttFkXb5Ia9D0yBSYVkb1bXxqYteFS5X1a1Eb8jnGyFuHkG
         D5kg==
X-Forwarded-Encrypted: i=1; AJvYcCWdUgSzbNymKCFnLyACgVcvV1Hx52PJzIxr3OF3ccedxncAVIRv1ia4pUW6orEkPZEtXhSQKNQZBGvP@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi13W5pQ4R0pMaHxkJTDp9u4ddx7q1tFx7hTyp5L8EDD/azeKl
	AsUSW4p3XUsPSF+GploHY5SJcys4I4s5BpHWt8LwSAAxZWryItuWvrFCVgGcLH6isgh4qF2FA2e
	HejKQmSo8btvKn8W/AwEjHlJUsNsAIk2MI4747aZNGQ==
X-Gm-Gg: ASbGnctrLPyj0vfnOcjixFjSRK5YTL+XkM3vb1DkHnEoJ4qVQyEs2UHMiJu241xDy3W
	XHaEpH0rOhTCEmnp29jjFfGLcGbWf92iifYAhTn19rq0bBC4usRwXGT7iiO0ceEGuqapXO8iyrM
	UlgWOMaoHpyNxdcRu6raUUUWaNFYs+95EYeq0gNrjPdUb1TnmixZOYnsEx81Lxk//yPMT5pZQMG
	K8Ngo4Ym8AqnI1xjQVK+9Y5rmzlDzLwfxeHpB7BK97h6Wz4p1J7Ei3e9Py2mEVvYRCTiFSqi94j
	6iTndO44G0krpem/VRxH65flYPI=
X-Google-Smtp-Source: AGHT+IHMY6SoKSk0VgpDlYvVT6P+glN4Yq9XXIqVKd9jfwRPr/K5XWhLNKItsuRhohz/IcTpClBme4+jDstH4cTCaYk=
X-Received: by 2002:a17:907:7ea4:b0:b70:b5ce:e66e with SMTP id
 a640c23a62f3a-b72e02db993mr1289989566b.21.1762872251327; Tue, 11 Nov 2025
 06:44:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111122735.880607-1-andriy.shevchenko@linux.intel.com> <20251111122735.880607-5-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20251111122735.880607-5-andriy.shevchenko@linux.intel.com>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Tue, 11 Nov 2025 20:13:59 +0530
X-Gm-Features: AWmQ_bnAE43qdt9uTp5GKOPhntYFEAk4L2mYcClIlF1B_9-TbeBvnkuEckfJGvA
Message-ID: <CAO_48GE5LK7hD-KJHHoD-XCRjTPcZWApE2MVvs4OgVdr1=u+rg@mail.gmail.com>
Subject: Re: [PATCH v2 04/21] dma-buf: Switch to use %ptSp
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Corey Minyard <corey@minyard.net>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Alex Deucher <alexander.deucher@amd.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Rob Clark <robin.clark@oss.qualcomm.com>, Matthew Brost <matthew.brost@intel.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Vitaly Lifshits <vitaly.lifshits@intel.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Niklas Cassel <cassel@kernel.org>, Calvin Owens <calvin@wbinvd.org>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, Sagi Maimon <maimon.sagi@gmail.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Karan Tilak Kumar <kartilak@cisco.com>, 
	Hans Verkuil <hverkuil+cisco@kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Petr Mladek <pmladek@suse.com>, 
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, Max Kellermann <max.kellermann@ionos.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	openipmi-developer@lists.sourceforge.net, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	linux-mmc@vger.kernel.org, netdev@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, linux-pci@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-staging@lists.linux.dev, ceph-devel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Jonathan Corbet <corbet@lwn.net>, Gustavo Padovan <gustavo@padovan.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>, 
	Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Lucas De Marchi <lucas.demarchi@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Rodolfo Giometti <giometti@enneenne.com>, Richard Cochran <richardcochran@gmail.com>, 
	Jonathan Lemon <jonathan.lemon@gmail.com>, Stefan Haberland <sth@linux.ibm.com>, 
	Jan Hoeppner <hoeppner@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Satish Kharat <satishkh@cisco.com>, Sesidhar Baddela <sebaddel@cisco.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Andy,


On Tue, 11 Nov 2025 at 17:57, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Use %ptSp instead of open coded variants to print content of
> struct timespec64 in human readable format.
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Thanks for the patch.

FWIW, please feel free to add
Acked-by: Sumit Semwal <sumit.semwal@linaro.org>

Best,
Sumit.
> ---
>  drivers/dma-buf/sync_debug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma-buf/sync_debug.c b/drivers/dma-buf/sync_debug.c
> index 67cd69551e42..9e5d662cd4e8 100644
> --- a/drivers/dma-buf/sync_debug.c
> +++ b/drivers/dma-buf/sync_debug.c
> @@ -59,7 +59,7 @@ static void sync_print_fence(struct seq_file *s,
>                 struct timespec64 ts64 =3D
>                         ktime_to_timespec64(fence->timestamp);
>
> -               seq_printf(s, "@%lld.%09ld", (s64)ts64.tv_sec, ts64.tv_ns=
ec);
> +               seq_printf(s, "@%ptSp", &ts64);
>         }
>
>         seq_printf(s, ": %lld", fence->seqno);
> --
> 2.50.1
>
