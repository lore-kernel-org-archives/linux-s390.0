Return-Path: <orenl@cs.columbia.edu>
Message-ID: <4BE18B30.10700@cs.columbia.edu>
Date: Wed, 05 May 2010 11:13:52 -0400
From: Oren Laadan <orenl@cs.columbia.edu>
MIME-Version: 1.0
Subject: Re: [PATCH v21 001/100] eclone (1/11): Factor out code to allocate
	pidmap page
References: <1272723382-19470-2-git-send-email-orenl@cs.columbia.edu>
	<1272723382-19470-1-git-send-email-orenl@cs.columbia.edu>
	<3803.1272984193@redhat.com>
In-Reply-To: <3803.1272984193@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: David Howells <dhowells@redhat.com>
Cc: linux-s390@vger.kernel.org, linux-api@vger.kernel.org, containers@lists.linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, Matt Helsley <matthltc@us.ibm.com>, Serge Hallyn <serue@us.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Pavel Emelyanov <xemul@openvz.org>
List-ID: <linux-s390.vger.kernel.org>

Hi David,

I suppose you are looking for more details than those found in the
current patch-0 (http://lkml.org/lkml/2010/5/1/140).

We omitted them for brevity sake; here is a link to patch-0 of a 
previous post of the patchset: http://lkml.org/lkml/2009/9/23/423

Thanks,

Oren.

David Howells wrote:
> With a huge patch series like this, can you post a cover note at the front
> (usually patch 0) saying what the point of the whole series is?
> 
> David
> 
