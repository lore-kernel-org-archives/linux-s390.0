Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <55141866.6080007@linux.vnet.ibm.com>
Date: Thu, 26 Mar 2015 15:32:06 +0100
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/2] powerpc/mm: Tracking vDSO remap
References: <20150325121118.GA2542@gmail.com> <cover.1427289960.git.ldufour@linux.vnet.ibm.com> <b6ce07f8e1e0d654371aee70bd8eac310456d0df.1427289960.git.ldufour@linux.vnet.ibm.com> <20150325183316.GA9090@gmail.com> <20150325183647.GA9331@gmail.com> <1427317867.6468.87.camel@kernel.crashing.org> <20150326094330.GA15407@gmail.com> <5513E16D.1030101@linux.vnet.ibm.com> <20150326141730.GA23060@gmail.com>
In-Reply-To: <20150326141730.GA23060@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20150326143206.ujA6N_VYt_imH3WWv6wZZkRHLIf4QUdfiV4n26ukRzM@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-arch@vger.kernel.org, linux-mm@kvack.org, cov@codeaurora.org, criu@openvz.org
List-ID: <linux-s390.vger.kernel.org>

On 26/03/2015 15:17, Ingo Molnar wrote:
> 
> * Laurent Dufour <ldufour@linux.vnet.ibm.com> wrote:
> 
>>> I argue we should use the right condition to clear vdso_base: if 
>>> the vDSO gets at least partially unmapped. Otherwise there's 
>>> little point in the whole patch: either correctly track whether 
>>> the vDSO is OK, or don't ...
>>
>> That's a good option, but it may be hard to achieve in the case the 
>> vDSO area has been splitted in multiple pieces.
>>
>> Not sure there is a right way to handle that, here this is a best 
>> effort, allowing a process to unmap its vDSO and having the 
>> sigreturn call done through the stack area (it has to make it 
>> executable).
>>
>> Anyway I'll dig into that, assuming that the vdso_base pointer 
>> should be clear if a part of the vDSO is moved or unmapped. The 
>> patch will be larger since I'll have to get the vDSO size which is 
>> private to the vdso.c file.
> 
> At least for munmap() I don't think that's a worry: once unmapped 
> (even if just partially), vdso_base becomes zero and won't ever be set 
> again.
> 
> So no need to track the zillion pieces, should there be any: Humpty 
> Dumpty won't be whole again, right?

My idea is to clear vdso_base if at least part of the vdso is unmap.
But since some part of the vdso may have been moved and unmapped later,
to be complete, the patch has to handle partial mremap() of the vDSO
too. Otherwise such a scenario will not be detected:

	new_area = mremap(vdso_base + page_size, ....);
	munmap(new_area,...);

>>> There's also the question of mprotect(): can users mprotect() the 
>>> vDSO on PowerPC?
>>
>> Yes, mprotect() the vDSO is allowed on PowerPC, as it is on x86, and 
>> certainly all the other architectures. Furthermore, if it is done on 
>> a partial part of the vDSO it is splitting the vma...
> 
> btw., CRIU's main purpose here is to reconstruct a vDSO that was 
> originally randomized, but whose address must now be reproduced as-is, 
> right?

You're right, CRIU has to move the vDSO to the same address it has at
checkpoint time.

> In that sense detecting the 'good' mremap() as your patch does should 
> do the trick and is certainly not objectionable IMHO - I was just 
> wondering whether we could make a perfect job very simply.

I'd try to address the perfect job, this may complexify the patch,
especially because the vdso's size is not recorded in the PowerPC
mm_context structure. Not sure it is a good idea to extend that structure..

Thanks,
Laurent.
