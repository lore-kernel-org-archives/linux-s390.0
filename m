Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E780738C2C7
	for <linux-s390@vger.kernel.org>; Sat, 21 Mar 2026 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774103267; cv=none; b=kBwC6JmEy1CGcwH7D/q0dCW5nlB2h2wnnTlIYiPCZ6Zh+jeSugHu3gXChfihYwyt5d+ck8DlwYOpwTDDYk7QhhB4eL5I3K0JF/3kgEvqSSL8Jb4h/0L4iqF8L/sm4jViIxzYSuGZ6INp8IoaQk3NBoSSGcjydF6XKTLQhYRr9/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774103267; c=relaxed/simple;
	bh=XbJvTOd1ukwPGu2B9QSbSkII0ybcEyvvDNPe4pFXwFw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=F32zrugBVKxTuMY2DDFYTH9zDfO7C2tZFooo7U/V5PJ0O0HO1/jZ5PLDm23t/+AJx2kdtIcDqm/wMUdprO4ljDzLm5Epc5MlE2dw0AJ3JDjlc4pMQTOtwZ7P2+NvYowvvla8lp/wu2K/VYAoNMGlgk4tDCEaHyZ7ZPEnDdhbS2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=mGBersy6; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="mGBersy6"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4670676ba03so951858b6e.1
        for <linux-s390@vger.kernel.org>; Sat, 21 Mar 2026 07:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774103265; x=1774708065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=By+r1Fe/YcOBcCg/TUP/Rfl3T3jnspwWgDUfbTqj4k4=;
        b=mGBersy6NNuVGCzzex1I7u3IC6ckORW3S5x3pPRjUsQgq2WNIPS1fUUxi7klBu309v
         LuFeUd4PEbb0fnTBDEoPwTB4pacYiXus2ZdD4Lr1lh2EhRqfHkwi/CqYnDTRxAkt1YvO
         +fHEGoE07oTYSeZxZxxqZD62Lgz5PbJb6NSQN4R0OOkZWLNuP8IgpBx2VHjO+Uppy6fp
         Np2aLa/9fUgEhHQ69KbRK0TabRl2oeu5QnBYQ57RgKQRd0/pnDuzDaKwDqDkVTrMgSiV
         GpNZzXpxFwgkD7gkifWSSKFVUkDKDkC4zh08w6uerFTjhdjdklJnKU6CI+eTl0ua1ln/
         wu9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774103265; x=1774708065;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=By+r1Fe/YcOBcCg/TUP/Rfl3T3jnspwWgDUfbTqj4k4=;
        b=TGyZTok7o8c/+tYJoIpuPQdMNhzhSPU3rXDZtPmi0Lf1VZE7XoVgPCZ5J/dcpxxEfj
         KUZ9NVu8qmZXuPRVLCsh9lklsA63T34n9Z9o4Bgn3zPd9VBx2YnkfzQjc3cUHAoqLw2Q
         2H50JJnKli1dpZ9IK0N1S0nTrQ0dVn/JhdjgQGbxFAF3JWqC4cz0WDH2bt04adJlDnoF
         UctkslZoZ5qOlBHQIWw6Md3ufWYmdTgI3ipA4DEJOstqnyn7rhy9Yn3l+fTTb8Gi4jkl
         BydXktUVOhbeGI33v/plO3g2vgykL0DvnrKESl56md5QkxjBlVmcqXj6hBIiKhxA3ob3
         8YsA==
X-Forwarded-Encrypted: i=1; AJvYcCX4uGMicsG7298LzisWg/QlXKe2V2tb9p2FysQlKvf2/3PlAegCrrrAj8JeFwiSJzG5lJVnb252VtNE@vger.kernel.org
X-Gm-Message-State: AOJu0YyLciF4NQD385XK2GrsOsMlohQ9EpRMjSmj6T6ph7MCvO+o7/sn
	sPZMfH8UtdlnnEVQP2uj7JDiwmANSacfRW73VqcBcM61GToaF0jOrVrUgVfIn2ImLes=
X-Gm-Gg: ATEYQzwhtffF/xZr0HDJ1++UOrDswo/6ApJVFsMQfWmpi7ywfNRZoOct9Un7+u+TbXL
	Vo0qyFM86zqiDZiOGCtysJVzW0rxMHppvgJqkZGLiYhcve5oEilKw8PnBrU7nOOwB9Yykr1/xIk
	dFO/EmtzIUreft25n9imTOa7oTh3vNxAHgvBAkZRB/mOoDgODZLBLcuUWCl/j9Ktcnt+Hdeh7ho
	45tNerMRW+/YHBLf9yDU0a7vaY+Ookt0XOh4mVYXkqFjQG8LG8uF6tZsejGVv+jOFAAl1ZNtjLr
	rmLS1ybezxsO0egxx0q0Jt7KDfAX9Pn+KZQAZO+26ahJPPEdMDdJS6w/InAoVow9muy4sshMXRc
	ORDazzU+hQ+Sz25jKDqst6sA/a3VtR7A9x6qZlDX93Pmp4+uUdzCHrXdFqKsX0L7O5KWtQ48Qcw
	e2dtur9FzGPsPthR2qVKvn4mxt18hXe0HM1rPVr1DBU6HmLjVKHpOlm6lp1/S5WyX35S0iCN0og
	eMe
X-Received: by 2002:a05:6808:1392:b0:467:255a:7453 with SMTP id 5614622812f47-467e5d9638fmr3487371b6e.14.1774103264871;
        Sat, 21 Mar 2026 07:27:44 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-467e7f131b2sm3215075b6e.15.2026.03.21.07.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 07:27:44 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Kees Cook <kees@kernel.org>
Cc: Josh Law <objecting@objecting.org>, Davidlohr Bueso <dave@stgolabs.net>, 
 Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, 
 "Richard Russon (FlatCap)" <ldm@flatcap.org>, 
 Thorsten Blum <thorsten.blum@linux.dev>, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-efi@vger.kernel.org, 
 linux-s390@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net, 
 linux-hardening@vger.kernel.org
In-Reply-To: <20260321004840.work.670-kees@kernel.org>
References: <20260321004840.work.670-kees@kernel.org>
Subject: Re: [PATCH] block: partitions: Replace pp_buf with struct seq_buf
Message-Id: <177410326319.185838.7918397412644396915.b4-ty@b4>
Date: Sat, 21 Mar 2026 08:27:43 -0600
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0


On Fri, 20 Mar 2026 17:48:44 -0700, Kees Cook wrote:
> In preparation for removing the strlcat API[1], replace the char *pp_buf
> with a struct seq_buf, which tracks the current write position and
> remaining space internally. This allows for:
> 
> - Direct use of seq_buf_printf() in place of snprintf()+strlcat()
>   pairs, eliminating local tmp buffers throughout.
> - Adjacent strlcat() calls that build strings piece-by-piece
>   (e.g., strlcat("["); strlcat(name); strlcat("]")) to be collapsed
>   into single seq_buf_printf() calls.
> - Simpler call sites: seq_buf_puts() takes only the buffer and string,
>   with no need to pass PAGE_SIZE at every call.
> 
> [...]

Applied, thanks!

[1/1] block: partitions: Replace pp_buf with struct seq_buf
      commit: c2d466b9fe1913f8dbe2701156c38719c94188f7

Best regards,
-- 
Jens Axboe



