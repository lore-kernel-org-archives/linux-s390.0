Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA511474A7
	for <linux-s390@vger.kernel.org>; Sat, 12 Oct 2024 21:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728770322; cv=none; b=cyhv/lHQxPMRIhcymgj34K3utSKHwCpjUsD6mU2QV2axQPSb9bK8/90XCgT8T/7JfI57M6dOuDp1kRwLy1JRovUM0uOOGdGgd6He/k5ijZSutT0eQ+GIGZxaT596GG9CkW5xJAclX6XMm/HW916G9ORlFH+0BuIDlSfn6RxiNxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728770322; c=relaxed/simple;
	bh=4p9zMCHyTvIHqWb+RiLLmYJIcUZSBcLyXxn110UCViQ=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=kaJ+zwKdQPCQgpNGOfAX0mcUWpfshEv1pt7cBj1A6X0j0BKyljxL5UvJi4Toc9tS90C02iEre9lhzPP/fdqa/lvSIveeta2HtV0dM6RG1pLEe472b+6I12EH4wAMKqKyfMfcy2rpdg1hj+kwhvroWsmkaQlFZxnt1iCU56GRANs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PC/V2+8G; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PC/V2+8G"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-71df4620966so2800409b3a.0
        for <linux-s390@vger.kernel.org>; Sat, 12 Oct 2024 14:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728770319; x=1729375119; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4p9zMCHyTvIHqWb+RiLLmYJIcUZSBcLyXxn110UCViQ=;
        b=PC/V2+8G39dq9Am41BkT94uLvBvOwQ2fw6rg+2TdP2AbbenuqxuyWEqT5FODeRMRfj
         zW8vru8wdt6D55nooemFYOWx1xQ69VyH6MiMln90NymhPeeEbwWzeazEZHhxw3GaCy2s
         CK+N+ALwenAQvd7I6Xa1u3OovSWe8SoyegbzTZq02wVths2zrNOZbthrJti6zkXOzutm
         5jcSc4ZPRAUdAZDgyx7kNjH44rhZf1nUPi6Wmpk6yQk7lwRpgczQy8r9uBvft814dHmn
         wCpgbGycfrJ6Vk2QF+cwFeMr4D2Gdb7zqWbfzmS4syT1PeVPNjZUgZCOcjJsiIxo/XnW
         8pmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728770319; x=1729375119;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4p9zMCHyTvIHqWb+RiLLmYJIcUZSBcLyXxn110UCViQ=;
        b=nw9Rq+vvMP16tU4TiaCnjxcl1FgjQ7liNNuFPY657O5yLHdRDUbInVOtyCply52trD
         FY4j6g1JD29G2dJHQhqrPRVq7isRXGJDuxf7UdXJixm62tx8+z6FNi9l8R3VTQAXN7s2
         2j4vN3sD1CRnvGNQzcHSwQTkIrgJFC3eJp6aWYCIvwJwx5PBEt0NCJ/qVxE7lEFrnEir
         VklbklNg6rWhPOFQwY18n8JwwWHPbThNJP2EijR2f89wHCqzlkbOu4kb9T5QJn0dqsjQ
         iNUq2EVos34/v9exYuMYCPz5idSOJFtn4U/syMSv2fiZtWA6wrW9D9Kss3llyFzMymUI
         2Znw==
X-Gm-Message-State: AOJu0YxYFJnHLMRA+zIVKtRHBBWf9n+4yrk3jfvzTLO99gnh3bEdD3nN
	Rd55kEdixKVzyXofOs93Ecz4d/wTQjUda7VzpjmDDhMoTc/TmYU9lyUYVXD6
X-Google-Smtp-Source: AGHT+IFmvRFRI/IZyuQJZzTf8BmEUTAfAQq6cu6/1NCi6YCIlOiUrkjpax+lO7LbPjgmu1/jHuhn1Q==
X-Received: by 2002:a05:6a00:b4b:b0:71e:5e04:be9b with SMTP id d2e1a72fcca58-71e5e04bfc0mr91950b3a.12.1728770319289;
        Sat, 12 Oct 2024 14:58:39 -0700 (PDT)
Received: from [103.67.163.162] ([103.67.163.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e4bfa6534sm1914676b3a.108.2024.10.12.14.58.38
        for <linux-s390@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Oct 2024 14:58:38 -0700 (PDT)
From: Josey Swihart <pankajsingh2071994@gmail.com>
X-Google-Original-From: Josey Swihart <joswihart@outlook.com>
Message-ID: <d5d6de0cf4a29308349b434bb837687a4881b978cc86e633dbfd25f9ce8d0de1@mx.google.com>
Reply-To: joswihart@outlook.com
To: linux-s390@vger.kernel.org
Subject: Yamaha Piano 10/12
Date: Sat, 12 Oct 2024 17:58:36 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello,

I?m offering my late husband?s Yamaha piano to anyone who would truly appreciate it. If you or someone you know would be interested in receiving this instrument for free, please don?t hesitate to contact me.

Warm regards,
Josey
