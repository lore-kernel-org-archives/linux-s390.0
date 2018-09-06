From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Thu, 06 Sep 2018 10:07:17 +0000
Subject: Re: [GIT PULL] s390 patches for the 4.19 merge window #2
Message-Id: <20180906100717.GC3598@osiris>
In-Reply-To: <d3724f12-6027-a1da-fb9d-cd085fe05397@linux.ibm.com>
References: <d3724f12-6027-a1da-fb9d-cd085fe05397@linux.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Sep 06, 2018 at 11:56:08AM +0200, Harald Freudenberger wrote:
> +out:
> +��� if (m)
> +��� ��� kfree(m);
> +��� return rc;
> �}

Please call kfree(m) unconditionally. Otherwise we will receive a
semi-automically generated patch within hours, as soon as this hits
upstream.
