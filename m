Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632CB379C2F
	for <linux-s390@vger.kernel.org>; Wed, 13 May 2026 06:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778654724; cv=none; b=K3AWYpMu5QCwuFaacl0P4tY4ZsieVJvew781btFx/ollzlhq9g9nY358RFgzIemTh1crnDCZlm4oVqGlZNcWYWVKIar2qha7B1yiC3TAE9Q2Sex0kHCuU060sQMqktJKkYPF/gfZyr5j97R/ky86pCBABuSUgUKowzWRIVvNe3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778654724; c=relaxed/simple;
	bh=UbqLcD/n4v9/Ngn2+4DlIeMfW07tqVE8aBBN62PlleI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdA1bejoIT8WfCFFj/d3QsPOVpy1WrCsaavW4LZskUY2oWMcygHTi1Q8KsaRpUvz5TO652ZV/rbUu6Dp3CNolYULD1IAcWDDk+5aFh3QjwDpreZW/zWpzN0frwFGEDIcs3z3y2ewVFa4MQ1IGK/T9vlhVFQQilrixL4tHXJi8Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SrNONMsf; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SrNONMsf"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-44a5174670eso3532495f8f.1
        for <linux-s390@vger.kernel.org>; Tue, 12 May 2026 23:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778654722; x=1779259522; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k93jNbFsgBY3MlSTxImzToR0APgHl6uw97YoSg32KR0=;
        b=SrNONMsfa8DF1XfQgRyIbo1/uzmg8ghKVC5sYwW1ZH1DqPt7zgt/IeNgikpC1FwBQy
         dlgdVtzaWnhS0KQqTCfQgog3BlVffK2C2sHQefzNgg+nkQSH5U8Wty9045k7Lnf1V/Dr
         eIXSWlIdd5aedGO76IK85lAEsn76FOguz+jYnayd+FW3r1wQ9w5NdjgxgdKw3IrtfYuN
         BdnRZwFllkC7m40QrL+430hFLNu7mIcZFWX7b9B09M/6mvTQ1sPgjjqoG5a2w1Hfa5ZL
         8kd55gq7xzFXlmF+5qiqz93UHSotrrQdmcTsYDnVUFhG/Tk2h1n+2LLPlaBeo2Z9cczt
         lpYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778654722; x=1779259522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k93jNbFsgBY3MlSTxImzToR0APgHl6uw97YoSg32KR0=;
        b=EonhcfGCAF8a8yTDCoxpG3M0e5AWUQ6ASBcoCo2xzjAfHNli6GClJox74uXOvv/Vnf
         xvRLkAaXLJdq0QNDYbq9OxUu+YjwRIwmnY5QgBc7/La571cEuv6aZCMoATrxDIn/oEAu
         A+JWNtM3jA2IrYaYWbDBxDlmfbOLTA6wAQ7w4+v00L+Kw8uf6iPQtm39m0crxdgg1Bek
         lm/d9fS7QM7CJRnV0deczwhiCqC6PBY/z6YJxXS2s7Wqoz4NBxsB9S1tkMo19RTyuq55
         zJRtX6EwA6cfNFO5J5rFrmcrtTgTm8BuWvWqOADdc9ZI5bW/R6bXBZz06tb+SdhJ7Y08
         3izA==
X-Forwarded-Encrypted: i=1; AFNElJ+Cl0t18o0qJzH85CzF5tEyCOub+uxTMmDgpXo/y4eAt8z+cM2gxZft0Ejt+4l3/hBPWTXN6hUDWzXr@vger.kernel.org
X-Gm-Message-State: AOJu0YxfE6rPls9o2qfvwWc0CdA2dj2UP1vCaGSWjwpR7YzLZE+AQurj
	aV1rhKxXIIgVfL4b1kUphkmQmFny3BYowMbau5dT6PxqWRzx+TKxER6SSZl+XqBvCR6LLwadVDq
	uQGZbLrM=
X-Gm-Gg: Acq92OHtUDzt7mqc72GMyWrRo8aJdJd+koYyceDgK5CpvrshcDG7+O5mh0oNmTqc8uc
	IDsHjKJhn1jKt3E/0O2zLOMlyxlbmK2jV6ymlnEabHfULdZEGrRGBO/JmqwGcwtXaOT6N/+mMIV
	c2HjSBC1nIE4BxPyPkz0ZH6amat+wFzX1dhT3GSg07Qg03ESHQj2gW+/RvJ4lHOI6sEEp+Dyt/t
	Qw5xVK4wKqS/+qRI17IObMrc/24my8/RoBiVUXIvaT3wIbL6IL/xDuW2v8Ut7PhoyRhz+LXNuJR
	ihtTX4Ok56DxUgIfrolXF/YBHI6gQ/cmUOuo/CuVEm1+SQPTA6WNBux1eRq6eci+0BQS2lyIo7N
	kzXLmRe/1OzcdwG4X0t7GLn7UTf6dOLMN0IQV2+orHFMewR1CsvVmBIH4x+PyoBAGdq8qMR/bz0
	qVlqCvtdfYY1h1bLSyQ9nXVYbuzWx6P3rZ3r18
X-Received: by 2002:a05:600c:4ed1:b0:48d:361:4df6 with SMTP id 5b1f17b1804b1-48fce9bfdecmr17101375e9.9.1778654721650;
        Tue, 12 May 2026 23:45:21 -0700 (PDT)
Received: from localhost (109-81-93-105.rct.o2.cz. [109.81.93.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f3e174fsm53304665e9.3.2026.05.12.23.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 23:45:21 -0700 (PDT)
Date: Wed, 13 May 2026 08:45:20 +0200
From: Michal Hocko <mhocko@suse.com>
To: Minchan Kim <minchan@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, akpm@linux-foundation.org,
	hca@linux.ibm.com, linux-s390@vger.kernel.org, david@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, surenb@google.com,
	timmurray@google.com
Subject: Re: [PATCH v2] mm: process_mrelease: introduce
 PROCESS_MRELEASE_REAP_KILL flag
Message-ID: <agQeABD0W7wn4pCt@tiehlicka>
References: <20260429211359.3829683-1-minchan@kernel.org>
 <afMnKrYT0xG_a-b3@tiehlicka>
 <afUYfpwWsUQoB9hz@google.com>
 <afhQB0CWEcflXpOi@tiehlicka>
 <20260505-wegbleiben-deshalb-f929089dbdab@brauner>
 <afoUt3te1k2TNao-@tiehlicka>
 <afowD31YsGVdVUBP@google.com>
 <agJN2esiIGIhUlMG@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agJN2esiIGIhUlMG@google.com>

On Mon 11-05-26 14:44:57, Minchan Kim wrote:
> Posted v3 - https://lore.kernel.org/linux-mm/20260511214226.937793-1-minchan@kernel.org/

Is there any reason to fragment the discussion into yet another email
threat? I believe Christian is still catching up after LSFMMBPF last
week so give him some time to have a look at this proposal before
sending yet another version please.

-- 
Michal Hocko
SUSE Labs
