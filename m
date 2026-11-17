Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794958486;
	b=f0rGD+roF/KqeLRTOj9PgbPc6pWNmgBIOi+sn8BSmbV6KHBF30LvCpwfUPcJDB6D4VNW
	 zpux9c6uRW0T92AgovfrvG8l324kIOrgQDTxqbam4nhbHuaUh5hF1HdqY4GPwOzpfYlyJ
	 BwOhLvBUApOb466BlNdiTeOjbbNZIoQ3suUQsVIbk+eYeoGyD+biFHr+8m8nGYyRDwXFt
	 TfzVtIbha5iBB4+ijlLo8+/5oagQX9RjOiri6gZXlq6Rww9E2mEZqN1UeRI+Ii9g1H2Pl
	 01MdHPdibdxKhgpBffuKPU3Xn0JSz8YSd+k1YOf1/sD2H9nOi8TOLL3jjKnyyr4U4OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794958486;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:From:To:Cc:Subject:References:In-Reply-To;
	bh=id7sxPUZ1q5vwEsAL+ZQA4c7CaWDRU0GTvUGmQVP1r4=;
	b=jcf+bkOo1ZSogForDJf+OCotQutkcH8uaeJByKxeG+wkZnTwJiBhR968WQaDJMcyMzTN
	 FGZnCiFLx4EOj3QysU6XEHz4EPjT2vAPS1oh1a1/NehyfacNf6RTZhJWMJ6Ek5+VtriB7
	 KZflFFgXh6EzTuNMELNLFz+zUCpmq+2+ap4clC4y62lgDG/hriWqq7RaVqkvWKpJCCqcc
	 yd8AedZtMPG8pIuHviXJdn96PZd9w46XXz+7I4CzvSN7c+O5qkE8sr6OfugB/URkIuQDy
	 fsUkREoicIWlbXcNMIPv74gq0lLGkOulUnXxDZ089uN4WjYQIiD4xtMZ8bkR4A5nTDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=PRr5dLBj;
	arc=none smtp.remote-ip=209.85.222.175
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B75606A32A
	for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 23:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45B75606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=PRr5dLBj
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-949680e6d83so36875685a.3
        for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 15:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1794958484; x=1795563284; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=id7sxPUZ1q5vwEsAL+ZQA4c7CaWDRU0GTvUGmQVP1r4=;
        b=PRr5dLBjAs05ylRi2AXLL0lTt2IRquA8ljp3pqeJPErlk/8PgAPrbJeb5L3wCfYpa4
         XDYg/SSGs1hy4t8K+/Pp2PiFQx3NJhZscZFEkHYDBy/vZZXIK8wPt1b8bU/aiP11Aror
         r2GnSzAJl8YAMrvOZ9zn1J7tRliIlMrZCaSyvO1BKafTr1o5vnDRkuheZbUs3qaGJKbw
         GZZ0QuyXsQLRhhKtgXaxoG43vf79JCmBRlf2ehljTRfDruOrXulaw85CZqHDE9ak195A
         eJ6eF8rJUuh1V7SM65zr4OBPFIDmlixPlsEtIh2VtMq10Xt4Rwuc5EzZPn5JnzwasjJF
         zOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794958484; x=1795563284;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=id7sxPUZ1q5vwEsAL+ZQA4c7CaWDRU0GTvUGmQVP1r4=;
        b=BlbjrDOjYTNpV0yxeQz/1gaDE74f9quo9yRc5mKEZStzXoX2LFLO+x/OiPVnaT9Xok
         X7aftgF1bzOWri1YyCfqY++R5ePOV8bTX0uS0k8Ko0Fz3Mb2ST9IZXMoASUOh7fkZstt
         SVKBsU5GdvS9k8yCVvVR+4yzSolZw9q4sQmPyc+T/GF1LIVNROy44/J6vH+i8deqCRju
         eki1UMjebUZIRcbQQPAEipvIH9K+B7lWJULvs73K5pUL5LyCUtZKi0r9LSFV2x94gPbq
         c3h5rdfgWXO3Pes+6OcH3QMKvnq6pG/nRreJvrWEpsfTQ+m/6WB2azbgGVwjhGJDz+s/
         F/ww==
X-Forwarded-Encrypted: i=1; AL+hErHGclA0q/SMGVZIBYZhY1dgUumDQA3Z/whE2AGPSbotzj4P7Z9C2R/Yiwhea0Z4WEma7rq1p2TzD4ot@vger.kernel.org
X-Gm-Message-State: APuU4Z9/kTGP5DxUN06p25e+VWMlkCIc5g1HckIZAEyJ3zi3vB+sj1fD
	b5FPhZtjNMvkMaIM3T4dRFzPRt/HlnH7gplAaFGpGaiyHtTpoHphdEtrMUqA4YdjyA==
X-Gm-Gg: AYBFou3RrSh+ynbbnTWDy0A7qFkAGedktuKMfpeuaJ9JSvQpuw10ImFc0MAWu5Rybid
	4taq8MkL0KvDzspJBTXUSsHh15xH26jI1RhzpwwcvGhZj9LrdndWqxVChYhYJpB95xa7LzUWNiP
	1ETeiHonAgM3TjnKopL7q0B4W6XiirAxdypISSJp3pWixvnOHQ47VjU8rjP6zxnHHcaZ4Xu19wS
	N9AgmcD/Wf1aE9M3IDSToai98jQCG1SaCsdR33OZWC3ATzfkS9nsgnsZBJECIekdPhjqPqoPbk5
	hBWxMjM6YmPqrBlFeEmO5ByHF4ueXHVgl9/jZNwqtt49u3Jzvd9MqVvlM9yht/AO3RHQUMgJtAi
	W/GaJ8JDIdLFOX7RKGEeEO4I2dM9Crp/YBzejiFM2Ur3LzMCxLnzo1QFd6hgj458lAO8cjwST7u
	WR0mgpN8jw3qeQkszM5EKDr+sQ97mVEt3UC6l+ccyhHwwHCoiOIcI6naWHObsr4WjecKxWQ43Vk
	4fWu5UCHS95oIKQdYQ4jb/dGEVaA58+xso2hWojAgqyAxgmNVkNE5vZUgPIxUW6n1afgKznXxCK
	19+h5opPx4shjCg+34QPCz6bgMIyqXaFjh0hBmLcnKGS3Wwn7koAfgyZa7vWoSy8pda64GlkTZ1
	cr52qBm4ediSnCQaZg8hKUECmLkei2S8=
X-Received: by 2002:a05:620a:2906:b0:944:dbd:8253 with SMTP id af79cd13be357-949995ee428mr247457685a.59.1794958484257;
        Tue, 17 Nov 2026 15:34:44 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9499b7c9a65sm41585085a.34.2026.11.17.15.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 15:34:42 -0800 (PST)
Date: Tue, 17 Nov 2026 18:34:41 -0500
Message-ID: <7a012ff555beb43b389ba5ab96e25ba3@paul-moore.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20261117_1552/pstg-lib:20261117_1552/pstg-pwork:20261117_1552
From: Paul Moore <paul@paul-moore.com>
To: sashiko-bot@kernel.org, "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH RFC v3 18/44] selinux: use fc_init_pseudo() for selinuxfs
References: <20261116-work-loop-pseudo-v3-18-8cbbea1cf34f@kernel.org>
In-Reply-To: <20261116-work-loop-pseudo-v3-18-8cbbea1cf34f@kernel.org>

On Nov 16, 2026 sashiko-bot@kernel.org wrote:
> 
> Initialize selinuxfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> SB_I_NOEXEC. selinuxfs never holds executables. SB_I_NOEXEC also
> refuses PROT_EXEC mappings but the status and policy files are only
> ever mapped for reading.
> 
> But selinuxfs needs device nodes. The kernel replaces file descriptors
> with /sys/fs/selinux/null on exec via dentry_open() which doesn't care
> about SB_I_NODEV. Android init however opens /sys/fs/selinux/null by
> path as /dev/null doesn't exist yet at that point. So clear SB_I_NODEV
> again in sel_fill_super().
> 
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> Tested-by: Chris Down <chris@chrisdown.name>
> ---
>  security/selinux/selinuxfs.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 310e19efff1d0..d7ae853b6d685 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -18,6 +18,7 @@
>  #include <linux/vmalloc.h>
>  #include <linux/fs.h>
>  #include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
>  #include <linux/hex.h>
>  #include <linux/mount.h>
>  #include <linux/mutex.h>
> @@ -1852,6 +1853,9 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
>  		/* last one */ {"", NULL, 0}
>  	};
>  
> +	/* Android init opens the null device below by path. */
> +	sb->s_iflags &= ~SB_I_NODEV;

See my comment in patch 17/44, this is also used internally in the
flush_unauthorized_files() function.  Once again I would prefer the
comment to be changed to the following:

  /* allow for the /sys/fs/selinux/null device node */

Acked-by: Paul Moore <paul@paul-moore.com>

>  	ret = selinux_fs_info_create(sb);
>  	if (ret)
>  		goto err;
> @@ -1955,6 +1959,7 @@ static const struct fs_context_operations sel_context_ops = {
>  
>  static int sel_init_fs_context(struct fs_context *fc)
>  {
> +	fc_init_pseudo(fc);
>  	fc->ops = &sel_context_ops;
>  	return 0;
>  }
> 
> -- 
> 2.53.0

--
paul-moore.com
