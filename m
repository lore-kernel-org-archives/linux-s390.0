Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F7F157A41;
	Wed, 16 Oct 2024 03:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729049914; cv=none; b=BOg/gRdsk4GLMhvW2qR50qWRKSS0Wvkd/URLBkt5L76NArfPyULDTcfpTz5rZtKcafKZz1QuOkbLUHxKF5h48Fc3TKUKPQvxadMuOg9Ahcb3lvYFpmVs8IfeSpcbzgIEfIhZ7VjPa2QgKVTmv1N1OB/1jgCJw6dH5l3z4KxNJIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729049914; c=relaxed/simple;
	bh=IiwQTOReGpHpyc57pvtjEfBBpq/82DCVCZB2+aVwLdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmFIIoy4YIcQERG+UfXf7Wz4TmNnXc91BXGzDzg7W9qRwexEGozAtM41j1XQEx0Qt23Or2AaveCsT7ZhlCNoKrQ3wAbOUsFgYZ7orqI7ZeNOXdP5smAkgkBfnlW8fBU/CdbzLHYqRQFlIyVPJv7C/hLeSrfmF3qjtmpYHWCC1Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSWt+MhC; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSWt+MhC"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2ed59a35eso4541182a91.0;
        Tue, 15 Oct 2024 20:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729049913; x=1729654713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YOVrKg3W/lMlewNmiQ2TbyPettlnm3jdFbJlR9Wuzis=;
        b=aSWt+MhCTgL6gSM7aaA3pChsAp0I3xOz3LvjV2iqhchJeaEjqHBpmEjb3UW8WesN8n
         y9H3YCMnvh2IE2BTuORQJHnd6sg2For8tYpo0YwDIWoYxC5agnm61uWd9sAic8ZRlP+T
         T2w9exAVimTzKkyQtNg4hUHIHuyAlGyJFfGPHttxyh7WUO01UdxkqLjtGPgcYYDsrz/E
         lbcefe8QL9E3Tor1tHZG5jhTEf85lkGNqvxAbPCsCv6C/eqqTWn8/nfTWbPC2Pl0qzUc
         sTBWYdokdMs3x+0dit2mFvVqKkvp8NSGYdancnYyseGp1FMImZNo86K5AUNxZkkgWyM1
         +9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729049913; x=1729654713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOVrKg3W/lMlewNmiQ2TbyPettlnm3jdFbJlR9Wuzis=;
        b=M0PbqqcmEAAAOYMdPa+lKb6x9MKjB+zYuutVLoS1Rs58tvAtPtEdBf0fO33pHsro+5
         1Wamdmhbp9CG5BQQQ7v5wg4PnwwSYWVWPvGvPYbcpUDsONQEqs5/cD4H0Gz/FAOUlBvK
         vckW4Pc+8IijOdRW1IC3PG0GdqdliICnjEIEkcYvILbLBg7w55VJPgC3Iw8O6M+7loE7
         NX+5Q+zWjrvbDngrzUETrxdl4lT40i0vNKLxangz25pNW4+jVBV8lwbmkhn19I6TV1Wr
         XUj8IbfsoXkWSV4WCcTapg47j/crFnP30WJBY3xDX8WfHZBfGo7tZbyXjlvF2wtuk1L/
         AxHw==
X-Forwarded-Encrypted: i=1; AJvYcCWF6R4xpnODEr6idnxyrHl7KFyvgLoPK/ZRqFtehzFlCRUNhOqx/kD5Sunv6rQ/1z7kDIkcza6w@vger.kernel.org, AJvYcCWOfZZ3ZnKi2CFd/8eJYTZK3b6zxL4jmJvfddGYFTtC4qfCnpp+giRH2m6A6nT5b8UGUuC1ooz/c5o3rA==@vger.kernel.org, AJvYcCWT+cmq9BGdMsItcojo8xYULKvIcPPBO3NE2Zpyy5MVakQ20hYQVshNTdH03NBQwbXapE6fhgJfM4VBsmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK3PJvOMezCvMLw+ZL7/1c3hfwT9UBlPCVnip4kNMXXfGJkLUB
	wEcROUUIGe+jR8/fyeVBYzX1ashc9yGwq3pqrOHMQRNnwk27K0+HPPzlmQ==
X-Google-Smtp-Source: AGHT+IE3vnWlR7rGXqBZsgmkw8xrNg/Q9W20jINBB6XcWIz0wpEmNiY/PEfBGkaLCcIUlyXo+pNhCA==
X-Received: by 2002:a17:90a:e7c4:b0:2e2:d82b:d144 with SMTP id 98e67ed59e1d1-2e3ab8e2885mr3170552a91.37.1729049912721;
        Tue, 15 Oct 2024 20:38:32 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e392e8ce39sm2832641a91.12.2024.10.15.20.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 20:38:32 -0700 (PDT)
Date: Tue, 15 Oct 2024 20:38:30 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
	Yangbo Lu <yangbo.lu@nxp.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] ptp: Add clock name to uevent
Message-ID: <Zw81Nlx9OF-PveY0@hoboy.vegasvil.org>
References: <20241015084728.1833876-1-svens@linux.ibm.com>
 <20241015084728.1833876-3-svens@linux.ibm.com>
 <c9c1c660-9278-426c-9290-b9b0cb76dcaf@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9c1c660-9278-426c-9290-b9b0cb76dcaf@lunn.ch>

On Tue, Oct 15, 2024 at 02:43:28PM +0200, Andrew Lunn wrote:
>  * @name:      A short "friendly name" to identify the clock and to
>  *             help distinguish PHY based devices from MAC based ones.
>  *             The string is not meant to be a unique id.
> 
> If the name is not unique, you probably should not be using it for
> udev naming.

+1

Maybe the name is unique for s390, but it will not be in general.

Thanks,
Richard
