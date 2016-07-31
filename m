From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 4/5] s390: Define AT_VECTOR_SIZE_ARCH for ARCH_DLINFO
Date: Sun, 31 Jul 2016 08:23:04 -0400
Message-ID: <20160731082304.05f4aad7@mschwide>
References: <1469462394-8970-1-git-send-email-james.hogan@imgtec.com>
	<1469462394-8970-5-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <1469462394-8970-5-git-send-email-james.hogan@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 25 Jul 2016 16:59:53 +0100
James Hogan <james.hogan@imgtec.com> wrote:

> AT_VECTOR_SIZE_ARCH should be defined with the maximum number of
> NEW_AUX_ENT entries that ARCH_DLINFO can contain, but it wasn't defined
> for s390 at all even though ARCH_DLINFO can contain one NEW_AUX_ENT when
> VDSO is enabled.
> 
> This shouldn't be a problem as AT_VECTOR_SIZE_BASE includes space for
> AT_BASE_PLATFORM which s390 doesn't use, but lets define it now and add
> the comment above ARCH_DLINFO as found in several other architectures to
> remind future modifiers of ARCH_DLINFO to keep AT_VECTOR_SIZE_ARCH up to
> date.
> 
> Fixes: b020632e40c3 ("[S390] introduce vdso on s390")
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: linux-s390@vger.kernel.org

The patch makes sense. I not quite sure about the checkpoint-restore code
that clears the last two entries of the user_auxv[] without knowing how
many aux entries there really are. That seems kind of strange.

I will the patch to our repositories and we'll give it a spin. If there
is no fallout I queue it to linux-s390.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
