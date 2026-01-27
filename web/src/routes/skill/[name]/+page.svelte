<script lang="ts">
  import type { PageData } from './$types';
  import { Badge } from "$lib/components/ui/badge";
  import { Button } from "$lib/components/ui/button";
  import { Separator } from "$lib/components/ui/separator";
  import { ArrowLeft } from "lucide-svelte";

  let { data }: { data: PageData } = $props();
</script>

<div class="container mx-auto py-10 px-4 max-w-4xl">
  <div class="mb-6">
    <Button href="/" variant="ghost" class="gap-2 pl-0 hover:pl-2 transition-all">
      <ArrowLeft class="size-4" />
      Back to Skills
    </Button>
  </div>

  <div class="flex flex-col gap-6">
    <div class="flex flex-col gap-4">
      <div class="flex items-center justify-between flex-wrap gap-4">
        <h1 class="text-4xl font-bold tracking-tight">{data.skill.name}</h1>
        {#if data.skill.metadata?.version}
          <Badge variant="secondary" class="text-lg px-3 py-1">v{data.skill.metadata.version}</Badge>
        {/if}
      </div>
      
      <p class="text-xl text-muted-foreground">
        {data.skill.description}
      </p>

      {#if data.skill.metadata}
        <div class="flex flex-wrap gap-3 mt-2">
          {#if data.skill.metadata.license}
            <Badge variant="outline">License: {data.skill.metadata.license}</Badge>
          {/if}
          {#if data.skill.metadata.author}
            <Badge variant="outline">Author: {data.skill.metadata.author}</Badge>
          {/if}
        </div>
      {/if}
    </div>

    <Separator />

    <div class="prose prose-slate dark:prose-invert max-w-none">
      <!-- eslint-disable-next-line svelte/no-at-html-tags -->
      {@html data.skill.content}
    </div>
  </div>
</div>
