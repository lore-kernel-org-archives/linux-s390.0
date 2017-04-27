From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [GIT PULL 0/2] s390/cpacf: base patches for msa8 cpu model
Date: Thu, 27 Apr 2017 09:53:49 +0200
Message-ID: <20170427095349.2baabac1@mschwideX1>
References: <1493210291-58638-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1493210291-58638-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 26 Apr 2017 14:38:09 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Martin,
> 
> please pull the following branch to get two base patches that are
> needed for the s390/kvm cpu model into your features branch.
> 
> I will also pull this branch as a base for an additional KVM patch.
> The pull request for the KVM maintainers will follow after this one.
> 
> The following changes since commit 97da3854c526d3a6ee05c849c96e48d21527606c:
> 
>   Linux 4.11-rc3 (2017-03-19 19:09:39 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  s390forkvm
> 
> for you to fetch changes up to 152c1c8d60ebedce8cc912c12f9be9ceca6c6671:
> 
>   s390/cpacf: Introduce kma instruction (2017-04-26 14:15:43 +0200)
> 
> ----------------------------------------------------------------
> Jason J. Herne (2):
>       s390/cpacf: query instructions use unique parameters for compatibility with KMA
>       s390/cpacf: Introduce kma instruction
> 
>  arch/s390/include/asm/cpacf.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Now merged with linux-s390:features. Thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
