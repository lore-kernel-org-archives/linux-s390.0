Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C262F126F3A;
	Tue,  5 Mar 2024 14:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709649561; cv=none; b=CW/ChFfl8e5kzdg731tWkdYRUucXbe7CAutMUbmiOEITk5+542EJE0zsFMLdVUWTM/s9UodJrLP4JjDFuJVLAWFW6MP9eO7INCWwnLY/3oLO+cKsVlCHr2R/rF2HcUoipU7iT0eLyf7JaUzMmDyDsCC6c+H1HQFAjSUFbMTi9DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709649561; c=relaxed/simple;
	bh=VXYVh26H39H4eClFASx5MAprD+QLoyzmy+clGPfLEUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gdlqiyoUcQA3AXUoBTjzXBUKF7Hvv1uSQj8nd+9KixA307YK/qMMcN6CdcAlxNJIPdHXJrGi+IYk3BT5W2GFkuzqlTB4Ult98D/riOg8oHv1J7u560C5Lm9QzPHq9xQSPQr+aTddyVp7q/ahGC78V9YJm6uqIWEMlCaIrbV/zrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1883568C7B; Tue,  5 Mar 2024 15:39:15 +0100 (CET)
Date: Tue, 5 Mar 2024 15:39:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Jan Hoeppner <hoeppner@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/3] dasd: move queue setup to common code
Message-ID: <20240305143914.GA6083@lst.de>
References: <20240221125438.3609762-1-hch@lst.de> <20240221125438.3609762-3-hch@lst.de> <14bad51d-734e-4d4e-b47a-3f6af6794a40@linux.ibm.com> <20240227152025.GB14628@lst.de>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227152025.GB14628@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

Can you review the v3 with this addressed?

